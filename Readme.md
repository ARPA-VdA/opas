OPAS (OPen Air System) è un sistema informatico per l'acquisizione, l'elaborazione statistica e la trasmissione dei dati ed il controllo della strumentazione in stazioni automatiche per il rilevamento di dati meteorologici e atmosferici (es. stazioni multiple su di una stessa piattaforma Hardware o software dedicati per l’acquisizione di dati in formati diversi da quelli standard).
Il sistema permette di acquisire i dati dei sensori geografici dislocati in stazioni, gestire e visualizzare tali dati.
Il sistema è formato da tre parti:
1- Database: database PostgreSQL che memorizza i dati raccolti e gestisce le impostazioni del PortaleRMQA (utenti, configurazioni, ecc). Viene fornito un dump della struttura vuota, senza dati che permette di fare l'accesso al PortaleRMQA con utente "user" e password "1234". Deve essere modificato il file "app.conf" per accedere al database in essere (creazione non parte del progetto).
2- LoggerNET: sistema di acquisizione scritto in Visual Basic.
3- PortaleRMQA: portale web basato su framework Mojolicious da cui si gestiscono le stazioni.
