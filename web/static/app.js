/*
Copyright © 2024 ax-i-om <addressaxiom@pm.me>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

tempTab = ""

const corCoef = 4.875;

const initialData = []

function getSelected(selectEl) {
    return [...selectEl.options].find(o => o.selected)
}
  
function findMaxLengthOpt(selectEl) {
    return [...selectEl.options].reduce((result, o) => o.textContent.length > result ? o.textContent.length : result, 0)
}

function resizeAll() {
    for (let i = 0; i < document.querySelectorAll('[id="querytype"]').length; i++) {
        const seList = document.querySelectorAll('[id="querytype"]')[i]
        if (typeof initialData[i] === 'undefined') {
            initialData[i] = [seList.offsetWidth, findMaxLengthOpt(seList), ""]
            initialData[i][2] = initialData[i][0] / initialData[i][1] 
        }
        const newOptValLen = getSelected(seList).textContent.length
        const correction = (initialData[i][1] - newOptValLen) * corCoef
        const newValueWidth = (newOptValLen * initialData[i][2]) + correction
        // console.log('new width', newValueWidth, 'new option len', newOptValLen)
        document.querySelectorAll('[id="querytype"]')[i].style.width = `${newValueWidth}px`;
      }
}

const initialSeList = document.querySelector('#querytype')
initialData[0] = [initialSeList.offsetWidth, findMaxLengthOpt(initialSeList), ""]
initialData[0][2] = initialData[0][0] / initialData[0][1] 
initialSeList.addEventListener("change", _ => {
  resizeAll()
}, false);

/**
 * Function to add a row of information to a string
 * @param table The result table where the row will be added
 * @param key The key to be used
 * @param value The value to be used
 * @returns Nothing
 */
function add(tablestring, key, value) {
    return tablestring += `<span style='display:flex; padding: 5px'><strong>${key}:&nbsp;</strong>${value}</span>`;
}

/**
 * Function to add line to a string
 * @param tablestring The result string where the line will be added
 * @param toAdd The string to be appended
 * @returns Nothing
 */
function append(tablestring, toAdd) {
    return tablestring += toAdd
}

function craftQuery(mQT, mQV, fQ) {
    let body = `q=${mQT}:${mQV}`
    if (fQ) {
        for (const fQkey of Object.keys(fQ)) {
            body += `&fq=${fQkey}:${fQ[fQkey]}`
        }
    }
    return body
}

function launch() {
    $('#queryloadercircle').addClass('loader');
    const mainType = $('#querytype').val()
    const query = $('#query').val()
    document.getElementById('queryresult').innerHTML = ""
    let addedQueryFlag = true
    let sameUsed = true
    
    const queryArr = {}

    if (document.querySelectorAll('[id="addedQuery"]').length > 0) {
        for (let i = 0; i < document.querySelectorAll('[id="addedQuery"]').length; i++) {
            const qKey = document.querySelectorAll('[id="addedQuery"]')[i].querySelector('[id="querytype"]').value
            const qVal = document.querySelectorAll('[id="addedQuery"]')[i].querySelector('[id="query"]').value
            if (!qVal) {
                addedQueryFlag = false
            } else if (Object.prototype.hasOwnProperty.call(queryArr, qKey) || qKey === mainType) {
                sameUsed = false
            } else {
                queryArr[qKey] = qVal
            }
        }
    }
    
    tempTab = ""

    if (query && addedQueryFlag && sameUsed) {
        $.getJSON(`/query/${craftQuery(mainType, query, queryArr)}`, (res) => {
                $('#queryloadercircle').removeClass('loader');
                tempTab = append(tempTab, `<span style='display:flex; padding: 5px'><strong>${res.response.numFound} results discovered (${res.responseHeader.QTime}ms), displaying 100</strong</span><br><br>`)
                if (res.response.docs.length > 0) {
                    for(let i = 0; i < res.response.docs.length; i++) {
                        const obj = res.response.docs[i];
                        Object.entries(obj).forEach((entry) => {
                            const [key, value] = entry;
                            if (key !== "_version_") {
                                if (key === "id") {
                                    tempTab = add(tempTab, `<strong><u>${key}`, `${value}</u></strong>`)
                                } else {
                                    tempTab = add(tempTab, `${key}`, `${value}`)
                                }
                            }
                        });
                        tempTab = append(tempTab, `<br>`)
                    }
                }
                document.getElementById('queryresult').innerHTML += tempTab
            })
    } else if (!addedQueryFlag || !query) {
        $('#queryloadercircle').removeClass('loader');
        tempTab = add(tempTab, "Error", "Query was not specified")
    } else if (!sameUsed){
        $('#queryloadercircle').removeClass('loader');
        tempTab = add(tempTab, "Error", "Cannot use the same query type multiple times")
    } else {
        $('#queryloadercircle').removeClass('loader');
        tempTab = add(tempTab, "Error", "Unexpected error occurred")
    }
    document.getElementById('queryresult').innerHTML += tempTab
}

$(document).keypress(function (e) {                                       
    if (e.which === 13) {
        e.preventDefault();
        launch() 
    }
});


$('#launchquery').on('click', () => {
    launch()
})

$("#addButton").click(function() {
    const qlen = document.querySelectorAll("#addedQuery").length
    if (qlen < 4) {
        $("#queryFieldHolder").append(`
            <div class="center-h" style="height: 3em; padding-bottom: 10px;" id="addedQuery">
            <form class="searchform">
            <select id="querytype" class="dropbutton"> 
            <option value="firstName">First Name</option> 
            <option value="lastName">Last Name</option> 
            <option value="emails">Email</option> 
            <option value="usernames">Username</option> 
            <option value="passwords">Password</option> 
            <option value="domain">Domain</option>
            <option value="ips">IP Address</option> 
            <!--option value="asnumber">ASN Number</option--> 
            <!--option value="asname">ASN Name</option-->
            <option value="continent">Continent</option> 
            <option value="country">Country</option> 
            <option value="phoneNumbers">Phone</option> 
            <option value="address">Address</option> 
            <!--option value="licenseplate">License Plate Number</option--> 
            <option value="birthYear">Birth Year</option> 
            <option value="vin">VIN</option> 
            <option value="city">City</option> 
            <option value="state">State</option> 
            <option value="zipCode">Zip</option> 
            <option value="source">Source</option> 
            <option value="recordid">Record ID</option> 
            </select>
            <input type="text" class="searchfield" spellcheck="false" autocomplete="off" id="query" placeholder="Query">
            </form>
            </div>`)
        if (qlen + 1 >= 4) {
            $('#addButton').attr('disabled',true);
        }
        if (qlen + 1 > 0) {
            $('#removeButton').removeAttr('disabled');
        }
        const end = document.querySelectorAll('[id="querytype"]')[document.querySelectorAll('[id="querytype"]').length - 1];
        end.addEventListener("change", _ => {
            resizeAll()
        }, false);
    }
    resizeAll();
});

$("#removeButton").click(function() {
    const qlen = document.querySelectorAll("#addedQuery").length
    if (qlen > 0) {
        document.querySelectorAll('[id="addedQuery"]')[document.querySelectorAll('[id="addedQuery"]').length - 1].remove();
        initialData.splice(-1);
        $('#addButton').removeAttr('disabled');

        if (qlen - 1 === 0) {
            $('#removeButton').attr('disabled',true);
        }
    }
})

window.onload = function() {
    resizeAll();
    $.getJSON("/records", (res) => {
        $("#rcounter").text(`${res.response.numFound} records indexed`)
    })
}