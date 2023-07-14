### Github repository : ecf_elastic_log.

# Activité Type 3 : Supervision des services déployés

Included tasks :
1. Mettez en place un ElasticSearch et connectez-le au Kubernetes.
2. Mettez en place un kibana et connectez-le au élasticsearch. Montrez des exemples de recherches sur les logs (kibana queries).

## Introduction :
<p>Works only when our AWS EKS Kubernetes cluster is up (see how : https://github.com/themaire/ecf_eks_terraform/).</p>
<p>In DevOps practice, monitoring what is happening on our infrastructure is critical. For that, the couple of tools ElasticSearch (database) and Kibana (dashbord) will help us a lot to keep a eye on our Kubernetes cluster and a demo NodeJS app (for exemple).</p>

### What I done :

## TASK 1-2 : Monitior a Kubernetes Cluster with ElasticSearch and Kibana

I created a account on https://cloud.elastic.co (paid service but 14 days trial account). Then, i created a "deployment", it is a kind of server.<br>
My "ECF_STUDI" is ready to store and serve datas.
![ScreenShot](img/my_first_deployment.png)

Once entered in the deployment, i spotted a invitation to monitor a Kubernetes Server. Lucky i am, great help given here.
![ScreenShot](img/invitation_to_monitor_kubernetes_after_deployment.png)

The first thing to do is to inatall the Kubernetes integration (plugin) on our ElasticSearch server.
![ScreenShot](img/kub_integration_plugin.png)

My Kubernetes cluster is opérate and hosted by AWS, so i am able to apply the yaml format manifest file provided. <br>
It will deploy a POD who will send lot of cluster's logs. This is the <b>Elastic agent</b>.
<br><br>
Once deployed with the "kubectl apply -f ..." command, the page confirmed that Elastic agent is enrolled to ElasticSearch with success.

![ScreenShot](img/1_install-elastic-agent.png)



On the next page, we can choose witch data we want to be collected.
![ScreenShot](img/2_elastic-agent_add_integration_data.png)

The deployment is OK. Te two pods names "elstic-agent-*" are visible in the cluster pods list in the AWS console.
![ScreenShot](img/elastic-agent_pods_on_the_Kubernetes.png)

So, the step ONE of integration is complete. We need now to explore metrics and logs in the Kibana interface.
![ScreenShot](img/monitor_cluster_1-3.png)

Take a tour of various pre-configured <b>metrics</b> and <b>dashbords</b> relative to the cluster.
![ScreenShot](img/metrics_cluster_overview.png)
![ScreenShot](img/dashboard_elastic_agent_overview.png)
![ScreenShot](img/dashboard_metrics_kubernetes_cluster_overview.png)

![ScreenShot](img/dashboard_metrics_kubernetes_cluster_pods.png)


Steps are OK, wee seen various logs and metrics about eh cluster.
![ScreenShot](img/monitor_cluster_3-3.png)

<br>

## TASK 2-2 : Setup Kibana to exploit data from custom application via the ElasticSearch API.

1. Data from a demo NODEJS app.

I wrot a simple demo app who send some temporal datas to my ElasticSearch deployment each time à refresh the page. So i can now draw a usage graph of the app.

<br><br>
In the app, the full test date and the timestamp of the refreshed page is shown.

![ScreenShot](img/demo_app.png)

To show a integration via the API, i followed a exemple from https://www.elastic.co/guide/en/cloud/current/ec-getting-started-node-js.html to be able to send data to a index.

![ScreenShot](img/index_managment.png)

Queries can be defined into a index. It is called a view.
![ScreenShot](img/discover_view.png)

A view can be saved as a part of a custom created dashboard.
![ScreenShot](img/custom_dashboard-nodejs_ingests.png)