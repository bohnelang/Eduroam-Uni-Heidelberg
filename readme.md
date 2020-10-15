
Leider funktionierte das über eduroam-Konfigurationsassistent (CAT) installierte Profile bei meinem Ubuntu (Stand Okt 2020) nicht. 
Das Notebook wollte keine Verbindung herstellen. Erst eine genaue Analyse zeigte, dass die Restiktionen zu eng  und die Root-CA-Zertifikate nicht installiert waren. 

Das kleine Bash-Skript installiert eine funktionierendes Eduroam-Profil und installiert das notwendige CA-Ceritifactes Paket (falls noch nicht geschehen).

Die UniID und das Kennwort werden von dem Skript von der Kommanozeile eingelesen. 


