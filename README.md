### STUDI _ ECF FINAL _ Récapitulatif

Ce referentiel GitHub recence plusieurs autre réferientiels necessaires au diverses réponses à l'ECF final du Bachelor DevOps de l'école en ligne STUDI.FR .
<br><br>
Les explications des réferentiels référentiels ont été rédigés en anglais.

<br>

# Activité Type 1 : Automatisation du déploiement d’infrastructure dans le Cloud

### 1. Préparer un cluster Kubernetes à l'aide de l'outil Terraform.


Lien : https://github.com/themaire/ecf_eks_terraform

<br>

### 2. Ajoutez et configurer les variables d'environnement qui se connectent à la base de données.
Lien : https://github.com/themaire/ecf_bancash_back_deployment<br>

Ce repo concerne à la fois :<br>
- Le test, le buid et le déploiement de l'image docker dans le cluster créé.
- L'ajout de variables d'environnement sécurisés 'secrets' au sein du cluster et de leur definition dans les instructions de déployement en tant que pod dans le cluster.


- Le tout effectué à l'aide de l'outil Terraform.

# Activité Type 2 : Déploiement d’une application en continu

### 1. Créez une application Nodejs (hello word) à partir d’une image docker Nodejs que vous exposerez sur un port (de votre choix)
### 2.Dockerizez votre application Nodejs

Les question 1 et 2 sont traités sous ce lien : https://github.com/themaire/ecf_bancash_back

### 3. Écrivez le script qui build/test et le nodejs et déployez le sur le kube créé.

Etant donné que l'application de demonstration NODEJS est créé à l'interieur du fichier dockerfile, le test de l'application se résume à l'appel d'un "stage" nomé 'test' dans le dockerfile. Le build est est un stage nommé 'production'. A la fin du fichier main.tf, un script bash est chargé de build l'image Docker uniquement si la phase de test réussi.

Lien : https://github.com/themaire/ecf_bancash_back_deployment

### 4. Créez une application Angular (hello word).
### 5. Écrivez le script qui build/test et le Angular.
Lien : https://github.com/themaire/ecf_bancash_front

# Activité Type 3 : Supervision des services déployés

### 1. Mettez en place un elasticsearch et connectez-le au kubernetes.
### 2. Mettez en place un kibana et connectez-le au élasticsearch. Montrez des exemples de recherches sur les logs (kibana queries).

Lien : https://github.com/themaire/ecf_elastic_logs
