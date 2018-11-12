#include "lairtypes.h"
#include "ui_lairtypes.h"
#include "lairtemplate.h"
#include "lairtool.h"
#include <QMessageBox>
#include <QPointer>
#include <QSharedPointer>
#include <QTextStream>
#include "settings.h"
#include "mainwindow.h"
#include "lairluamanager.h"

LairTypes::LairTypes(LairLuaManager* manager, QWidget *parent) :
    QDialog(parent),
    ui(new Ui::LairTypes) {
    ui->setupUi(this);

    lairLuaManager = manager;
    lairName = new LairName(this);
    lairTemplates = NULL;

    setWindowTitle("Lair Template tool");

    connect(ui->pushButton_add, SIGNAL(clicked()), lairName, SLOT(show()));
    connect(lairName, SIGNAL(accepted()), this, SLOT(createLair()));
    connect(ui->pushButton_remove, SIGNAL(clicked()), this, SLOT(removeLair()));
    connect(ui->pushButton_edit, SIGNAL(clicked()), this, SLOT(editLair()));
    connect(ui->pushButton_save, SIGNAL(clicked()), this, SLOT(saveLairs()));
    connect(ui->pushButton_load, SIGNAL(clicked()), this, SLOT(loadCurrentLairTypes()));

    this->setWindowFlags(windowFlags() | Qt::WindowMaximizeButtonHint | Qt::WindowMinimizeButtonHint);
}

LairTypes::~LairTypes() {
    delete ui;
    delete lairName;
}

QList<QString> LairTypes::getLairTypes() {
    QList<QString> lairTypes;

    if (lairTemplates == NULL)
        return lairTypes;

    return lairTemplates->keys();
}

void LairTypes::loadCurrentLairTypes(bool skipDialog) {
    if (!skipDialog && !QMessageBox::question (this, "Load lair templates", "Are you sure?\n All current changes will be lost", QMessageBox::Ok, QMessageBox::Abort) == QMessageBox::Ok)
        return;

    ui->listWidget_lairs->clear();

    lairLuaManager->reload();

    lairTemplates = lairLuaManager->getLairTemplates();

    QMapIterator<QString, LairTemplate*> i(*lairTemplates);

    while (i.hasNext()) {
        i.next();

        //LairTemplate* templ = i.value();
        QString name = i.key();

        ui->listWidget_lairs->addItem(name);
    }

}

void LairTypes::editLair() {
    int idx = ui->listWidget_lairs->currentRow();

    QListWidgetItem* item = ui->listWidget_lairs->item(idx);

    if (item == NULL)
        return;

    QString lair = item->text();

    lair = lair.replace('*', "");

    LairTemplate* lairTemplate = lairTemplates->value(lair, NULL);

    if (lairTemplate == NULL)
        return;

    item->setText(lair + "*");

    LairTool* tool(new LairTool());
    tool->setTemplate(lairTemplate);
    tool->show();
}

void LairTypes::saveLairs(bool forceUpdate) {
    if (!forceUpdate && QMessageBox::question (this, "Save lair templates", "Are you sure?", QMessageBox::Ok, QMessageBox::Abort) != QMessageBox::Ok)
        return;

    Settings* settings = MainWindow::instance->getSettings();

    for (int i = 0; i < ui->listWidget_lairs->count(); ++i) {
        QListWidgetItem* item = ui->listWidget_lairs->item(i);

        QString name = item->text();

        if (name.contains('*')) {
            QString actualLairName = name.replace('*', "");

            LairTemplate* templ = lairTemplates->value(actualLairName, NULL);

            if (templ != NULL){
                //QString data = templ->serializeToLua();

                //MainWindow::instance->outputToConsole(data);

                QString data;
                QTextStream streamData(&data);

                streamData << "-- Generated by LairTool" << endl;

                streamData << templ->serializeToLua() << endl << endl;

                QString currentName = templ->getFileName();

                QString fullFileName;

                if (currentName.isEmpty()) {
                    fullFileName = settings->getServerDirectory() + "/bin/scripts/mobile/lair/" + actualLairName + ".lua";
                } else {
                    fullFileName = settings->getServerDirectory() + "/bin/scripts/mobile/" + currentName;
                }

                QFile file(fullFileName);
                if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
                    MainWindow::instance->outputToConsole(data);

                    QTextStream outFile(&file);
                    outFile << data;

                    file.close();

                    //templ->setFileName(fileName);
                } else {
                    MainWindow::instance->warning("could not open file " + fullFileName);
                }

                MainWindow::instance->outputToConsole(fullFileName);
            }

            item->setText(actualLairName);
        }
    }

    //save the includes

    QString fullFileName = settings->getServerDirectory() + "/bin/scripts/mobile/lair/serverobjects.lua";

    QFile file(fullFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        MainWindow::instance->warning("could not open file " + fullFileName);

        return;
    }

    QMapIterator<QString, LairTemplate*> i(*lairTemplates);

    QTextStream outFile(&file);

    outFile << "includeFile(\"lair/lair.lua\")" << endl;

    while (i.hasNext()) {
        i.next();

        QString name = i.key();

        outFile << "includeFile(\"lair/" << name << ".lua\")" << endl;
    }

    file.close();
}

void LairTypes::removeLair() {
    if (QMessageBox::question (this, "Delete lair", "Are you sure?", QMessageBox::Ok, QMessageBox::Abort) != QMessageBox::Ok)
        return;

    int idx = ui->listWidget_lairs->currentRow();

    QListWidgetItem* item = ui->listWidget_lairs->takeItem(idx);

    if (item == NULL)
        return;

    QString name = item->text();

    name = name.replace('*', "");

    delete lairTemplates->value(name, NULL);
    delete item;

    lairTemplates->remove(name);
}

void LairTypes::createLair() {
    QString name = lairName->getName();

    if (lairTemplates == NULL)
        lairTemplates = new QMap<QString, LairTemplate*>();

    if (lairTemplates->contains(name)) {
        QMessageBox::warning(this, "Warning", "Lair Template already exists");

        return;
    }

    if (name.isEmpty() || name.contains('*')) {
        QMessageBox::warning(this, "Warning", "Invalid name");

        return;
    }

    LairTemplate* lair = new LairTemplate(name);

    lairTemplates->insert(name, lair);

    ui->listWidget_lairs->addItem(name + "*");

    LairTool* tool(new LairTool());
    tool->setTemplate(lair);
    tool->show();
}
