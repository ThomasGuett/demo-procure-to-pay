# on-prem agentic orchestration
This is a demo project designed to highlight on-prem orchestration including agentic processes, based on Camunda process orchestration

## Requirements to run

### technical requirements
Ensure the following components are already installed. This demo was tested using Docker, but podman should work just as well. Regarding Ollama, the demo requires a open-ai compatible local api interface, this worked best with Ollama, I tried to test it with nexa.ai, but unfortunately it didn't work as expected. It could also work with LM Studio or vLLM (but untested).
- Docker
- Ollama

### Camunda Process Orchestration
This demo assumes you spin up a self-managed Camunda 8.8 installation via docker-compose, as outlined here: [Camunda Docker Compose Self-managed guide](https://docs.camunda.io/docs/self-managed/deployment/docker/)

### Ollama Model download
This demo currently uses *qwen3:latest* as its LLM for the agentic part and *mistral-small3.2:latest* for its IDP part, this can be modified within the CheckInventory.bpmn files agentic subprocess model. To start with the demo, I highly recommend to download this model first and serve it with your Ollama installation.

### Prepare Demo setup
1. Clone this repository and start your Ollama and Camunda installation
2. Upload the used connectors from the connectors directory into your webmodeler (default: http://localhost:8070)
3. publish each connector to your organization to ensure availability in the web modeler
4. create a procure-to-pay project and upload the contents of the folder procure-to-pay-modeler-project
5. deploy CheckInventory.bpmn, procure-to-pay.bpmn and ApprovalLevels.dmn to the process engine
    - the forms will be automatically included in these deployments
6. start the secondary docker-compose file within this project
    - this will spin up a demo inventory db (used in the demo), a [db admin panel](http://localhost:8091), a webserver for the [start form](http://localhost:8000)
7. **IMPORTANT** CORS prevention: adjust your browser to ignore CORS settings
    - for Safari: go to Safari -> Preferences -> Advanced -> show features for web developers, then switch to the developer tab and select Disable cross-origin restrictions

### Demo Flow
Ensure you refreshed your browser window after deactivating your cross-oring restictions, then open up the [form](http://localhost:8000)

1. Request a 'Macbook', fill in the necessary other details and hit submit, if your prepations were successful you show now briefly see a green confirmation below with a unique id. 
This is the process instance id of the newly created process instance
    - Troubleshooting: If at this point a red notification appears, most likely your cors-restriction did not come through yet, double check for deactivated cors-checks or your webhook is not yet available double-check the procure-to-pay process was deployed successfully
2. Open [Operate](http://localhost:8088/operate) and go to the active procure-to-pay process instance
    - the process should now be going through the subprocess test-inventory-check
    - the agent should've successfully found a Macbook Pro within inventory 1
3. Open [Tasklist](http://localhost:8088/tasklist)
    - most likey (non-deterministic) either a 'get feedback' or 'reserve item in inventory' task are opened by the agent.
    - complete the task:
        - reserve item: click the item reserved checkbox
        - get feedback: write something like: 'yes that one will be fine' (just somehow state to the LLM that it completed the task, otherwise it will simply ask again for feedback)
4. Go back to Operate and see that the procure-to-pay process has finished
5. proceed with secondary request by opening the form again
6. Look for something that is not in the inventory e.g. an Apple Studio Display (price 1500)
7. Check in Operate that the agent will go through the inventory unsuccessfully
8. it will most likey then ask for feedback, simply respond like: thanks, that is all
10. The process will then continue deterministically and will spawn a task for the Department Head
11. **Important** the demo does not involve different roles, obviously in the real world these tasks would be assigned to different access level staff. For your audience (if you do the demo) or for your own understanding, the tasks will highlight who they address within their headers e.g. IT department head (or whatever department was selected when form was submitted)
12. after approval (automatic, department or CFO -> depends on amount, can be adjusted in the .dmn diagram), a task to upload the invoice gets created
13. The task is addressed to the original requester to now upload the invoice, use: invoice-example/Invoice...pdf
14. The invoice will then be automatically processed and a last approval task for finance will appear.


### Considerations / Modifications
I highly recommend to open the local [Camunda 8 console](http://localhost:8087) for easy access to all relevant tools. 
**Document Handling** By default the docker compose self-managed installation will default to in-memory Document handling, wich is fine for the demo, but might cause glitches after restarts etc.. Keep that in mind that this could be the reasons for invoices not showing up in tasks or the IDP application.

**Story flow adjustments** Feel free to modify the demo to your liking, as I am a bit of an Apple fanboy I centered it around Apple products, but any request will do fine. At first run the demo inventory databases will be initiated with the entries in the init.sql. These can be adjusted before the first run or simply adjusted afterwards within the [db admin tool](http://localhost:8091)

### default demo credentials
You will find the default credentials in the .env file. The default credentials for the Camunda Self-managed installation will be demo:demo

### Comment regarding code
The following resources include ai based code-gen: invoice-example (simply created as html then exported to pdf), the procure-to-pay webform (initially created and then modified to call correct webhook as well as some adjustments regarding the form data)

This project aims to show on-prem deterministic and non-deterministic process orchestration it is not meant to be feature or logic complete but rather to show a how-to or proof-of-concept.