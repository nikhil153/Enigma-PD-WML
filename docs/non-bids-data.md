# Running the pipeline on non-BIDS data

We recommend you convert your data to BIDS format before running the pipeline. However, if you have non-BIDS data, you
can still run the pipeline by following these steps:

- [install the pre-requisites](../README.md/#1-install-prerequisites)
- create a CSV file that describes the directory structure of your data
- run the pipeline using the CSV file

## Create a CSV file

You will need to create an CSV file that describes the directory structure of your data.

The CSV file must contain one row for each subject you want to analysis. It must contain the following columns:

- `flair`: path to the FLAIR MRI image for a subject
- `t1`: path to the T1-weighted MRI image for a subject
- `output`: basename of output files for a subject. The filename must not have an extension.

For example, if you have the following directory structure:

```bash
data
├───subject-1
│   ├───flair.nii.gz
│   └───t1.nii.gz
│
├───subject-2
│   ├───flair.nii.gz
│   └───t1.nii.gz
```

you would create the following CSV file:

```csv
flair,t1,output
subject-1/flair.nii.gz,subject-1/t1.nii.gz,enigma-pd-wml/subject-1/subject-1
subject-2/flair.nii.gz,subject-2/t1.nii.gz,enigma-pd-wml/subject-2/subject-2
```

> [!NOTE]
> All filename must be relative to the data directory from which you run the Docker or Apptainer image. For example,
> with the above directory structure you would run the Docker (or Apptainer) run command
> from the `data/` directory, and the paths in the CSV file must be relative to this
> directory.
<!-- markdownlint-disable MD028/no-blanks-blockquote -->
> [!WARNING]
> The output files must be stored in separate directories for each subject. For example, setting the above outputs files
> to instead be `enigma-pd-wml/subject-1` and `enigma-pd-wml/subject-2` would fail, because outputs for both subjects
> would be written to the `enigma-pd-wml` directory.

## Run the pipeline

To run the pipeline, follow the [instructions for running the container](../README.md#3-run-the-container), and pass to
`-l` flag to the run command, specifying the relative. For example, to run with Docker:

```bash
docker run -v "${PWD}":/data hamiedaharoon24/enigma-pd-wml:<tag> -l input.csv
```

assuming you have saved the CSV file as `input.csv` in the `data/` directory.

## Output data

After running the pipeline, you would have the following directory structure:

```bash
data
├── input.csv
├── enigma-pd-wml.log
├── subject-1
│   ├── flair.nii.gz
│   └── t1.nii.gz
│
├── subject-2
│   ├── flair.nii.gz
│   └── t1.nii.gz
│
├── enigma-pd-wml
│   ├── subject-1
│   │   ├── subject-1.zip
│   │   ├── subject-1.log
│   │   ├── input/
│   │   └── output/
│   └── subject-2
│       ├── subject-2.zip
│       ├── subject-2.log
│       ├── input/
│       └── output/
```

The [session-level zip files](../README.md#session-level-zip-files) are stored in
`data/enigma-pd-wml/subject-1/subject-1/subject-1.zip` and `data/enigma-pd-wml/subject-1/subject-2/subject-2.zip`. These
are the files you will need to send to the ENIGMA-PD Vasc team.

The [intermediate files](../README.md#intermediate-files) are stored in the
`data/enigma-pd-wml/subject-1/subject-1/input/` and `data/enigma-pd-wml/subject-1/subject-1/output/` directories for
`subject-1` (and the corresponding directories for `subject-2`).

The top-level [log file](../README.md#output-logs) is stored in `data/enigma-pd-wml.log`, and the are stored in
`data/enigma-pd-wml/subject-1/subject-1/subject-1.zip` and `data/enigma-pd-wml/subject-1/subject-2/subject-2.zip`.
