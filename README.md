<p align="center">
  <a><img src="./web/static/rapture.png" width=200 height="200"></a>
    <h1 align="center">Rapture</h1>
  <p align="center">
    <a><img src="https://img.shields.io/badge/version-0.1.0-blue.svg" alt="v0.1.0"></a>
    <a href="https://goreportcard.com/report/github.com/ax-i-om/rapture/web"><img src="https://goreportcard.com/badge/github.com/ax-i-om/rapture/web" alt="Go Report Card"></a><br>
    <a href="https://app.deepsource.com/gh/ax-i-om/rapture/" target="_blank"><img alt="DeepSource" title="DeepSource" src="https://app.deepsource.com/gh/ax-i-om/rapture.svg/?label=active+issues&show_trend=true"/></a><br>
   No-nonsense data-breach search engine <br>
</a>
  </p><br>
</p>

## Table of Contents

- [Information](#information)
  - [About](#about)
  - [Attribution](#attribution)
  - [Disclaimer](#disclaimer)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Data Conversion](#data-conversion)
  - [Data Importation](#data-importation)

## Information

### About

Rapture is a simple and cross-platform, "no-nonsense" data-breach search engine designed to enable individuals to effortlessly index and query compromised data to identify exposure and protect personal information and assets.

### Attribution

This software is heavily inspired by MiyakoYakota's search.0t.rocks ([Github](https://github.com/MiyakoYakota/search.0t.rocks) | [Archive](https://web.archive.org/web/20240313083920/https://github.com/MiyakoYakota/search.0t.rocks)), uses the same Solr configuration, and remains consistent with their core tenants of simplicity and usability. Thank you for your grand contribution to the development of open-source intelligence software and for providing a means for the community to expand on your developments.

### Disclaimer

It is the end user's responsibility to obey all applicable local, state, and federal laws. Developers will not under any circumstances distribute any compromised data. Developers assume no liability and are not responsible for any misuse or damage caused by this program. This software comes AS IS with NO WARRANTY and NO GUARANTEES of any kind. By using Rapture, you agree to the previous statements.

### Prerequisites

- Git
- Docker Engine w/ Docker Compose
- Java 8 or later

### Getting Started

A more comprehensive guide to configuring Rapture will be created in the near future. For now, the following instructions should suffice.

1. Fetch the repository via ***git clone***: `git clone https://github.com/ax-i-om/rapture.git`
2. Navigate into the root directory of the repository: `cd rapture`
3. Run: `docker compose build`
4. Run: `docker compose up -d`
5. Ensure setup script is executable: `chmod u+x setup.sh`
6. Execute the setup script: `./setup.sh`

That's it! You can now navigate to the Rapture web page at [`http://127.0.0.1:6175`](http://127.0.0.1:6175). It is preferred you use the host address `127.0.0.1` rather than specifying `localhost` when accessing Rapture. 

### Data Conversion

Below is an example of a valid/cleaned CSV file titled `header.csv`:
``` csv
id,emails,passwords,firstName,lastName
ficticiousbreach-03122024-1,rapture@demo.com,VK9RSuK0wSSXNc0gF8iYW1f6,axiom,estimate
ficticiousbreach-03122024-2,rapture@demo.com,N7cblKU9ypU727lwiTr9espw,garble,vortex
ficticiousbreach-03122024-3,rapture@demo.com,eP0u9cM0jAa2QeUVI3d88rYn,vertiable,slap
ficticiousbreach-03122024-4,rapture@demo.com,QxtyRMAx3KniskzjGDg6tHdl,axiom,terrific
ficticiousbreach-03122024-5,rapture@demo.com,cirSMQZp7Enh98KLb6r8JT1I,garble,eighty
ficticiousbreach-03122024-6,rapture@demo.com,9J53HQEetTv5E2xCJKe4tdaP,veritable,tumble
ficticiousbreach-03122024-7,rapture@demo.com,3sZ7NPb54Fk0Qy2LXlLejwCu,axiom,slipper
ficticiousbreach-03122024-8,rapture@demo.com,OxoZGbn3v0tvBMyWA0Jds0Ea,garble,chord
ficticiousbreach-03122024-9,rapture@demo.com,et8ggkgUeyQ3ge7ua2YNsOLd,veritable,baffle
```
Only the fields specified during the execution of `setup.sh` are valid, and fields are case sensitive; therefore, `firstName` is a valid key/field, whereas `firstname` and `FIRSTNAME` are invalid. Likewise, the `passwords` field is valid; however, the singular iteration of the word (`password`) is invalid. 

> [!NOTE] 
> Each data point is required to have an `id` field. It is up to you how to format this field; however, it is important that each and every occurrence of an `id` is unique. In the case of a duplicate `id`, data will be overwritten.

### Data Importation

The process for importing data is straightforward. In the example below, we will use the Solr post tool to post the data from the `header.csv` file exhibited above.

> [!NOTE]
> Supported file types: 
> `xml,json,csv,pdf,doc,docx,ppt,pptx,xls,xlsx,odt,odp,ods,ott,otp,ots,rtf,htm,html,txt,log`

> [!NOTE]
> The Solr post tool requires a Java runtime greater than version 8, and can be installed like so:
> `sudo apt install openjdk-19-jre-headless` 

1. Download Solr binary release from: [`https://solr.apache.org/downloads`](https://solr.apache.org/downloads)
2. Extract binaries: `tar zxvf solr-9.5.0.tgz`
3. Post data to Solr collection: `/home/axiom/Desktop/solr-9.5.0/bin/post -c BigData -p 8983 -host 127.0.0.1 header.csv`

Ensure that you change the command specified in step 3 to accomodate:

`/home/axiom/Desktop/solr-9.5.0/bin/post` - Path to Solr post binary extracted (extracted in step 2)

`-c BigData` - Collection name (Leave this as is, unless you modified `setup.sh`)

`-p 8983` - Solr service port (Leave this as is, unless you modified `setup.sh`)

`-host 127.0.0.1` - Solr service host address (Leave this as is, unless you modified `setup.sh`)

`header.csv` - File containing clean data you wish to post. This is the file we demonstrated in [Data Conversion](#data-conversion)

After you have posted the data, you should be able to refresh the Rapture web page and successfully query the information!
