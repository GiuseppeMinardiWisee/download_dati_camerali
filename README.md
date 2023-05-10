
## Script di esportazione di dati dal database PostgreSQL

Questo script Bash consente di esportare i dati di una vista in un file separato da tabulazioni (TSV) e di contare il numero di righe e colonne del file di output.

### Dipendenze

- PostgreSQL
- Bash

### Installazione

Per installare il comando ```psql``` usre i seguenti codici

```
sudo apt update $$ sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service
```

### Creazione del file .pgpass

Il file .pgpass consente di specificare le credenziali di accesso al database in modo sicuro, senza doverle inserire nel file di script. È necessario creare questo file e impostarne i permessi prima di utilizzare lo script.

1. Creare un file denominato `.pgpass` nella home directory.
2. Aggiungere una riga per ogni connessione al database con il seguente formato:
   ```
   hostname:port:database:username:password
   ```
   Se si vuole eseguire la connessione su qualsiasi porta, utilizzare `*` come valore di porta.
3. Impostare i permessi del file a 600:
   ```
   chmod 600 ~/.pgpass
   ```

In modo più conciso:
```
echo "hostname:port:database:username:password" >> ~/.pgpass && chmod 600 ~/.pgpass
```

### Utilizzo dello script

```
./export_view.sh [-o file_path] [-s separator] [-h db_host] [-p db_port] [-U db_user] [-d db_name]

Opzioni:
  -o file_path      Percorso del file di output. Default: $HOME/Documents/sedi_noesclusioni_latest.csv
  -s separator      Separatore di campo. Default: "\t"
  -h db_host        Host del database. Default: "dbwisee.cwjkkhwhfxrg.eu-west-3.rds.amazonaws.com"
  -p db_port        Porta del database. Default: "5432"
  -U db_user        Utente del database. Default: "dbwisee_user_ai"
  -d db_name        Nome del database. Default: "dbwisee"
```

Esempio di utilizzo:

```
./export_view.sh -o ~/Documents/my_view.tsv -s "," -h my_db_host -p 5433 -U my_db_user -d my_db_name
```

### Impostazione dei permessi

Per eseguire lo script, è necessario avere il permesso di esecuzione sul file. È possibile impostare i permessi eseguendo il seguente comando:

```
chmod +x export_view.sh
```

Inoltre, per utilizzare il file .pgpass, è necessario impostare i permessi del file come descritto sopra.
