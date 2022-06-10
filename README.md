# opas
OPen Air System
OPAS (OPen Air System) è un sistema di acquisizione, gestione ed elaborazione dati creato e utilizzato per la rete di misura della qualità dell’aria regionale della Valle d'Aosta.
Il sistema è composto da due componenti: l'applicativo web (PORTALE RMQA) e il datalogger di cabina (LoggerNET).
L'applicativo web basato sul framework Mojolicious e il linguaggio di programmazione Perl permette la gestione dell'intera rete (stazioni, strumenti, attività in campo) e si appoggia su un database PostgresSQL.
Il datalogger di cabina, scritto in Visual Basic, si occupa dell'acquisizione dati dagli strumenti e l'invio di questi all'applicativo web.

PORTALE RMQA
L'applicativo web è suddiviso nella parte database (database) e web (lily).
Il database usa il DBSM PostgreSQL (versione minima richiesta 9).
Dopo aver creato un database dedicato, si devono eseguire gli script SQL di creazione del database presenti in opas/PortaleRMQA/database/
Installare sul server di hosting i moduli per eseguire Perl (versione xxx) e il framework Mojolicious (versione xxx)
In seguito si deve importare l'applicativo web presente in opas/PortaleRMQA/lily in Mojolicious e avviarlo (vedere la documentazione ufficiale di Mojolicious).

LoggerNET
Il datalogger di cabina .... 
Il codice sorgente è scritto in Visual Basic xxx
