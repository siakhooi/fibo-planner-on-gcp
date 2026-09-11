default:
  @just --list
login:
  gcloud auth login
logout:
  gcloud auth revoke
project-list:
  gcloud projects list
billing-list:  
  gcloud billing accounts list

project_id := "fibo-planner"
project_name := "Fibo Planner"
region := "asia-southeast1"
run_id := "fibo-planner"

create-project:
  gcloud projects create "{{ project_id }}"  --name "{{ project_name }}"
default-project:
  gcloud config set project "{{ project_id }}"
  gcloud config get-value project
link-billing billing_account:
  gcloud billing projects link "{{ project_id }}" --billing-account={{billing_account}}
project-billing:
  gcloud billing projects describe "{{ project_id }}"
set-region:
  gcloud config set run/region ""{{ region }}
enable-services:
  gcloud services enable run.googleapis.com
  gcloud services enable logging.googleapis.com
  gcloud services enable billingbudgets.googleapis.com

cloud-run:
  gcloud run deploy {{ run_id }} --image=docker.io/siakhooi/fibo-planner:0.3.0 --allow-unauthenticated --max-instances=1

describe-run:
  gcloud run services describe "{{ run_id }}" --region="{{ region }}"
run-log:
  gcloud run services logs read "{{ run_id }}" --region="{{ region }}"

scale-0:
  gcloud run services update "{{ run_id }}" --region="{{ region }}" --min=0 --max=1
block:
  gcloud run services remove-iam-policy-binding "{{ run_id }}" --region="{{ region }}" --member="allUsers" --role="roles/run.invoker"
unblock:
  gcloud run services add-iam-policy-binding "{{ run_id }}" --region="{{ region }}" --member="allUsers" --role="roles/run.invoker"
get-iam:
  gcloud run services get-iam-policy "{{ run_id }}" --region="{{ region }}"

billing-budgets billing_account:
  gcloud billing budgets list --billing-account="{{ billing_account }}"

create-budgets billing_account:
  gcloud billing budgets create --billing-account="{{ billing_account }}" --display-name="{{ project_id }} monthly budget" \
  --budget-amount=1MYR \
  --calendar-period=month \
  --filter-projects=projects/{{ project_id }} \
  --threshold-rule=percent=0.50 \
  --threshold-rule=percent=0.80 \
  --threshold-rule=percent=1.00

delete-run:
  gcloud run services delete {{ run_id }} --region="{{ region }}"
delete-project:
  gcloud projects delete "{{ project_id }}"
