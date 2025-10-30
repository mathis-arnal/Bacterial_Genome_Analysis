---
title: A short introduction to Galaxy
level: Introductory
tags:
- español
questions:
- How to get started in Galaxy
objectives:
- Learn how to upload a file
- Learn how to use a tool
- Learn how to view results
- Learn how to view histories
- Learn how to extract and run a workflow
- Learn how to share a history
time_estimation: 40m
key_points:
- The Galaxy interface has an activity bar on the left, a tool (or other activated)
  panel next to it (if expanded), viewing pane in the middle, and a history of your
  data analysis on the right.
- You can create a new history for each analysis. All your histories are saved.
- 'To get data into Galaxy, you can upload a file by pasting in a web address. There
  are other ways to get data into Galaxy (not covered in this tutorial): you can upload
  a file from your computer, and you can import an entire history.'
- Choose a tool and change any settings for your analysis.
- Run the tool. The output files will be saved at the top of your history.
- View the output files by clicking the eye icon.
- View all your histories and move files between them. Switch to a different history.
- Log out of your Galaxy server. When you log back in (to the same server), your histories
  will all be there.
subtopic: first
priority: 2
---

!!! info "Lesson overview"
    **Teaching:** 30 min  
    **Exercises:** 10 min  

    **Questions**
    - How to get started in Galaxy ?

    **Objectives**
    - Learn how to upload a file
    - Learn how to use a tool
    - Learn how to view results
    - Learn how to view histories
    - Learn how to extract and run a workflow
    - Learn how to share a history

# Overview

* This is a short introduction to the Galaxy user interface - the web page that you interact with.
* We will cover key tasks in Galaxy: uploading files, using tools, viewing histories, and running workflows.

## Create an account on a Galaxy instance/server

If you already have an account, skip to the next section!

In Galaxy, *server* and *instance* are often used interchangeably. These terms basically mean that different regions have different Galaxy servers/instances, with slightly different tool installations and appearances. If you don't have a specific server/instance in mind, we recommend registering at one of the main public servers/instances, detailed below.

## What does Galaxy look like?

!!! example "Log in to Galaxy"
    1. Open your favorite browser (Chrome, Safari, Edge or Firefox, not Internet Explorer!)
    2. Browse to your Galaxy instance ([usegalaxy.org.au](https://usegalaxy.org.au/))
    3. Log in or register

    ![Screenshot of Galaxy Australia with the register or login button highlighted]( ../fig/galaxy/galaxy-login.png)

    !!! comment "Different Galaxy servers"
        This is an image of Galaxy Australia, located at [usegalaxy.org.au](https://usegalaxy.org.au/)

        You can also find more possible Galaxy servers depending on your region.

The Galaxy homepage is divided into four sections (panels):
* The Activity Bar on the left: _This is where you will navigate to the resources in Galaxy (Tools, Workflows, Histories etc.)_
* Currently active "Activity Panel" on the left: _By default, the  **Tools** activity will be active and its panel will be expanded_
* Viewing panel in the middle: _The main area for context for your analysis_
* History of analysis and files on the right: _Shows your "current" history; i.e.: Where any new files for your analysis will be stored_

![Screenshot of the Galaxy interface with aforementioned structure]( ../fig/galaxy/galaxy_interface.png)

The first time you use Galaxy, there will be no files in your history panel.

# Key Galaxy actions

## Name your current history

Your "History" is in the panel at the right. It is a record of the actions you have taken.

!!! example "Name history"
    1. Go to the **History** panel (on the right)
    2. Click ✏️ (**Edit**) next to the history name (which by default is "Unnamed history")

        ![Screenshot of the galaxy interface with the history name being edited, it currently reads "Unnamed history", the default value. An input box is below it.]( ../fig/galaxy/rename_history.png)

    3. Type in a new name, for example, "Galaxy Tutorial"
    4. Click **Save**

    !!! comment "Renaming not an option?"
        If renaming does not work, it is possible you aren't logged in, so try logging in to Galaxy first. Anonymous users are only permitted to have one history, and they cannot rename it.

## Upload a file

!!! example "Upload a file from URL"
    1. At the top of the **Activity Bar**, click the  **Upload** activity

        ![upload data button shown in the galaxy interface]( ../fig/galaxy/upload-data.png)

        This brings up a box:

    3. Click **Choose Local File** or Drop the files 
    4. Paste in the fastq.gz file from the JC1A sample:

    ```
    JC1A_R1.fastqsanger.gz
    ```

    5. Click **Start**
    6. Click **Close**

Your uploaded file is now in your current history.
When the file has uploaded to Galaxy, it will turn green.

After this you will see your first history item (called a "dataset") in Galaxy's right panel. It will go through
the gray (preparing/queued) and yellow (running) states to become green (success).

## What is this file?

!!! example "View dataset contents"
    1. Click the 👁️ (eye) icon next to the dataset name, to look at the file content

    ![galaxy history view showing a single dataset mutant_r1.fastq. Display link is being hovered.]( ../fig/galaxy/eye-icon.png){:width="320px"}

The contents of the file will be displayed in the central Galaxy panel. If the dataset is large, you will see a warning message which explains that only the first megabyte is shown.

This file contains DNA sequencing reads from a bacteria, in FASTQ format:

![preview of a fastq file showing the 4 line structure described in fig caption. 3 reads are shown.]( ../fig/galaxy/fastq.png "A FastQ file has four lines per record: the record identifier (`@mutant-no_snps.gff-24960/`), the sequence (`AATG…`), the plus character (`+`), and then the quality scores for the sequence (`5??A…`)."){:width="620px"}

## Use a tool

Let's look at the quality of the reads in this file.

1. Type **FastQE** in the tools panel search box (top)
2. Click the tool (**FASTQE** visualize fastqfiles with emoji's)
![fastqe click on the tool]( ../fig/galaxy/fastqe-click.png)
The tool will be displayed in the central Galaxy panel.

3. Select the following parameters:
    -  *"Raw read data from your current history"*: the FASTQ dataset that we uploaded (should be already selected)
    - No change in the other parameters
4. Click **Run Tool**

This tool will run and two one new output datasets will appear at the top of your history panel.
![fastqe sucess]( ../fig/galaxy/fastqe-success.png){:width="620px"}
## View results

We will now look at the output dataset called *FastQE on data 1*.

!!! comment "Comment"
    * Note that Galaxy has given this dataset a name according to both the tool name ("FastQE") and the input ("data 1") that it used.
    * The name "data 1" means the dataset number 1 in Galaxy's current history (our FASTQ file).

!!! example "View results"
    * Once it's green, click the 👁️ (eye) icon next to the "Webpage" output dataset.
    ![fastqe-view]( ../fig/galaxy/fastqe-view.png){:width="620px"}
    
    The information is displayed in the central panel
    ![fastqe-report]( ../fig/galaxy/fastqe-report.png){:width="620px"}


!!! exercice "Best and worst Quality"

    What is the best and worst quality for the mean ?
    What is the best and worst quality for the min ?
    What is the best and worst quality for the max ?
    Look at the scale displayed below : 

    ![fastqe-scale](../fig/galaxy/fastqe-scale.png)
    
    ??? sucess "Answer"

        - For the max: the worst is 36 (😜) and the best is 40 (😎)    
        - For the min: the worst is 2(👺) and the best is 24 (😊) 
        - For the mean: the worst is 24(😊) and the best is 38(😁) 


## Share your history

!!! example "Share your history"
    Imagine you had a problem in your analysis and want to ask for help.

    ![history-share](../fig/galaxy/history-share.png)

    Try to create a link for your history and share it with yourself.

    ![history-share-panel](../fig/galaxy/history-share-panel.png)

## Convert your analysis history into a workflow

Galaxy records every tool you run and the parameters used. You can convert this history into a workflow to reuse later.

!!! example "Extract workflow"
    1. Clean up your history: remove any failed (red) jobs
    2. Click (**History options**) → **Extract workflow**

    ![extract-workflow](../fig/galaxy/extract-workflow.png)

    3. Select the steps to include
    4. Replace the workflow name (e.g., `FASTQ Emoji Workflow`)
    5. Rename the workflow input (e.g., `FASTQ reads`)

    ![workflow-rename](../fig/galaxy/workflow-rename.png)

    6. Click **Create Workflow**

## Create a new history

Now, let's create a new history for our next analysis, which will be the Quality Checking.
We will name the new history according to the tool we will be using, here "FASTQC".

!!! example "New history"
    1. Create a new history
    2. Rename it, e.g., "FASTQC"

    ![new_history-fastqc.png](../fig/galaxy/new_history-fastqc.png)

This new history has no datasets yet.

## Copy the previous dataset in the new history

We want to do the quality checking on the data from our metagenomic analysis, the sample JC1A and JP4D from the Cuatro Ciénegas Basin.
Because we already uploaded the forward reads form JC1A (JC1A_R1), ze are going to copy the data from our first history "Galaxy Tutorial, to the history "FASTQC".

!!! example "View histories in History Multiview"
    1. Open **History Multiview** in the activity bar
    2. Or click **Show Histories side-by-side**
    3. Copy a dataset into your new history by dragging it from "Galaxy Tutorial" to "FASTQC"
    ![history_multiview_tutorial.png](../fig/galaxy/history_multiview_tutorial.png)
    4. Return to the main Galaxy window

!!! comment
    This is not the only way to view your histories in Galaxy:
    1. An exhaustive list is available in the **My Histories** tab
    2. You can quickly switch to another history using **History options**

# Conclusion

Well done! You have completed the short introduction to Galaxy:

* Named a history
* Uploaded a file
* Used a tool
* Viewed results

!!! Success "Key Points"
    - The Galaxy interface has an activity bar on the left, a tool (or other activated)
    panel next to it (if expanded), viewing pane in the middle, and a history of your
    data analysis on the right.
    - You can create a new history for each analysis. All your histories are saved.
    - 'To get data into Galaxy, you can upload a file by pasting in a web address. There
    are other ways to get data into Galaxy (not covered in this tutorial): you can upload
    a file from your computer, and you can import an entire history.'
    - Choose a tool and change any settings for your analysis.
    - Run the tool. The output files will be saved at the top of your history.
    - View the output files by clicking the eye icon.
    - View all your histories and move files between them. Switch to a different history.
    - Log out of your Galaxy server. When you log back in (to the same server), your histories
    will all be there.