default:
  @just --list
login:
  gcloud auth login
logout:
  gcloud auth revoke

projectname := "fibo-planner-cloud"
create-project:
  gcloud projects create {{ projectname }} 
  gcloud config set project {{ projectname }}

enableservice:
  gcloud service enable run.googleapis.com
  gcloud service enable logging.googleapis.com

gcloud config set run/region asia-southeast1

gcloud run deploy fibo-planner --image=docker.io/siakhooi/fibo-planner:0.3.0 \
  --allow-unauthenticated --max-instances=1
  
  

https://fibo-planner-xxxx-uc.a.run.app


gcloud run services delete fibo-planner --region=asia-southeast1

gcloud config get-value project

gcloud projects delete fibo-planner-cloud


==

gcloud billing accounts list
gcloud billing budgets create --billing-account=xxxxx --display-name="fibo-planner monthly budget" \
 --budget-amount=1USD \
 --calendar-period=month \
 --filter-projects=projects/fibo-planner-cloud \
 --threshold-rule=percent=0.50 \
 --threshold-rule=percent=0.80 \
 --threshold-rule=percent=1.00
 
gcloud billing budgets list --billing-account=xxxx-uc


