This is a local CI/CD pipeline which is a demo of real airflow and GitHub Actions.
The pipeline is triggered whenever there is any change made in codebase.
It is also triggered every 10 minutes using cron. 
It checks wether there is any formatting error or syntax error. 
Then it tests the functions by calling. 
Finaly after testing is successful, an archive is made
Which is then deployed to production

Structure:

local-pipeline/
├── app/
│ ├── main.py # the simple Python "app" you are testing
│ └── requirements.txt # dependencies (flake8, pytest)
├── tests/
│ └── test_main.py # unit tests for main.py
├── pipeline/
│ ├── 01_lint.sh # stage 1: check code style
│ ├── 02_test.sh # stage 2: run tests
│ ├── 03_build.sh # stage 3: package the app
│ └── 04_deploy.sh # stage 4: copy to a /prod folder
├── logs/ # each stage writes a log file here
├── builds/ # packaged builds get stored here
├── prod/ # simulated production environment
├── run_pipeline.sh # orchestrator: runs all 4 stages in order
└── trigger_watch.sh # watcher: detects changes, triggers pipeline


Comparison to Airflow:

- run_pipeline.sh is like an Airflow DAG — the main file that 
  defines the full flow
- Each stage script is like an Airflow Task/Operator
- Cron schedule maps to schedule_interval in Airflow
- trigger_watch.sh maps to event-based triggers in Airflow
- logs/ maps to Airflow's task logs

What Airflow adds that this project doesn't have:
- Retries individual failed tasks, not the whole pipeline
- Visual graph of the pipeline in a browser
- Email alerts when something fails
- Can run multiple pipelines in parallel
