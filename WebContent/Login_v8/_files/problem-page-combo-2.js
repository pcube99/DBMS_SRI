var editor = ace.edit("editor");
var Range = ace.require('ace/range').Range;
var _range;
var previousLanguage = '';
var problemType = pid > 700000 ?  'Function' : 'Full';
var themes = {"Theme Light":"ace/theme/chrome","Dark":"ace/theme/vibrant_ink","Monokai":"ace/theme/monokai","GeeksforGeeks":"ace/theme/gfg"};
var defaultCode = "";
var foldTextLength="", foldTextLengthC="", foldTextLengthCpp="", foldTextLengthJava="", foldTextLengthPython="", foldTextLengthPython3="",foldTextLengthCsharp="";
var userDefaultCode = $('#defaultCodeDiv').text();
getDefaultCode(problemType, function(systemCode) {
        defaultCode = systemCode;
        });

// function to check code is default code or not
function isCodeDefault(code) {
    for( var key in defaultCode ) {
        if(code == defaultCode[key] ) {
            return true;
        }
    }
    return false;
}

// default code  languages based on problem type
function getDefaultCode(problemType, callback) {
    if (problemType == "Full") {
        var defaultC = (def_lang == 'c') ? userDefaultCode : '#include <stdio.h>\n\nint main() {\n\t//code\n\treturn 0;\n}';
        var defaultCPP = (def_lang == 'cpp') ? userDefaultCode : '#include <iostream>\nusing namespace std;\n\nint main() {\n\t//code\n\treturn 0;\n}';
        var defaultJava = (def_lang == 'java') ? userDefaultCode : '/*package whatever //do not write package name here */\n\nimport java.util.*;\nimport java.lang.*;\nimport java.io.*;\n\nclass GFG {\n\tpublic static void main (String[] args) {\n\t\t//code\n\t}\n}';
        var defaultPython = (def_lang == 'python') ? userDefaultCode : '#code';
        var defaultCsharp = (def_lang == 'csharp') ? userDefaultCode : 'using System;\npublic class GFG {\n\tstatic public void Main () {\n\t\tConsole.WriteLine("Hello World!");\n\t}\n}';
        callback( { 'c': defaultC, 'cpp': defaultCPP , 'java': defaultJava , 'python': defaultPython, 'python3': defaultPython, 'csharp': defaultCsharp })

    } else if (problemType == "Function") {

        // below two varibles will be prepended to default code of languges(prependTextOther for c/c++/java and prependTextPython for python) to indicate user that this is a function problem.

        var prependTextPython = "''' "+"This is a function problem.You only need to complete the function given below"+" '''";

        var prependTextOther = "/*This is a function problem.You only need to complete the function given below*/";
        
        $.ajax({
            type:"GET",
            url:"/ajax/getsolution.php",
            data:{ pid : pid },
            async: false,
            success:function(data){
                var response = $.parseJSON(data);
                if(response[1]!=null && response[1] != '' && response[0]!=null && response[0] != '') {
                    var foldText = response[1].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthCpp = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultCpp="{\n"+response[1].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextOther+"\n"+response[0].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                if(response[3]!=null && response[3] != '' && response[2]!=null && response[2] != '') {
                    var foldText = response[3].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthC = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultC="{\n"+response[3].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextOther+"\n"+response[2].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                if(response[5]!=null && response[5] != '' && response[4]!=null && response[4] != '') {
                    var foldText = response[5].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthJava = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultJava="{\n"+response[5].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextOther+"\n"+response[4].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                if(response[7]!=null && response[7] != '' && response[6]!=null && response[6] != ''){
                    var foldText = response[7].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthPython = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultPython="{\n"+response[7].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextPython+"\n"+response[6].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                if(response[9]!=null && response[9] != '' && response[8]!=null && response[8] != '') {
                    var foldText = response[9].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthPython3 = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultPython3="{\n"+response[9].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextPython+"\n"+response[8].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                if(response[11]!=null && response[11] != '' && response[10]!=null && response[10] != '') {
                    var foldText = response[11].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                    foldTextLengthCsharp = foldText.split(/\r\n|\r|\n/).length ;
                    var defaultCsharp="{\n"+response[11].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n")+"\n}\n"+prependTextOther+"\n"+response[10].replace(/(?:\\[rn]|[\r\n]+)+/g, "\n");
                }
                callback( {
                    'c': ( typeof defaultC !== 'undefined' && defaultC != '' ) ? defaultC : null,
                    'cpp': ( typeof defaultCpp !== 'undefined' && defaultCpp != '' ) ? defaultCpp : null , 
                    'java': ( typeof defaultJava != 'undefined' && defaultJava != '' ) ? defaultJava : null , 
                    'python': ( typeof defaultPython != 'undefined' && defaultPython != '' ) ? defaultPython : null , 
                    'python3':  ( typeof defaultPython3 != 'undefined' && defaultPython3 != '' ) ? defaultPython3 : null,
                    'csharp':  ( typeof defaultCsharp != 'undefined' && defaultCsharp != '' ) ? defaultCsharp : null,
                })
            },
        });
    }
}

//local storage function to test that local varibale is available in browser or not
function isLocalStorageAvailable(){
    var testString = "test";
    try {
        localStorage.setItem(testString,testString);
        localStorage.removeItem(testString);
        return true;
    }
    catch(e) {
        if(e.name == 'QuotaExceededError'){
            localStorage.clear();
            return true;
        } else{
            return false;
        }
    }
}

// get previous selected theme from local storage if not set default value
function getPreviousTheme () {
    var previousTheme = localStorage.getItem('theme');
    if(previousTheme == "null") {
        previousTheme = "Theme Light";
    }
    return previousTheme;
}

function saveEditorChanges() {

    if(isLocalStorageAvailable()) {
        var dataObject = {};
        var code = editor.session.getValue();
    var testInput = '';
        var lang = previousLanguage;
        if( expectedArea.value != '')
          testInput = expectedArea.value;
        else if (testArea.value != '')
          testInput = testArea.value;

        dataObject[pid] = { code:code, lang:lang, testInput:testInput };
        var theme = $(".themeLight").parent().val();   // get current selected theme
        localStorage.setItem('theme',theme);
        if (lang != '' && code != '' && !isCodeDefault(code)) {
            localStorage.setItem('data',JSON.stringify(dataObject));
        }
    } else {
        console.log("Local Storage is not available");
    }
}

// write to local storage when a window is closed
$(window).unload(function() {
    saveEditorChanges();
});

function setEditorMode(language) {

    var mode;
    if(language == 'c') {
        mode = 'c_cpp';
        foldTextLength = foldTextLengthC;
    } else if (language == 'cpp') {
        mode = 'c_cpp';
        foldTextLength = foldTextLengthCpp;
    } else if (language == 'python') {
        mode = 'python';
        foldTextLength = foldTextLengthPython;
    } else if (language == 'python3') {
        mode = 'python';
        foldTextLength = foldTextLengthPython3;
    } else if (language == 'java') {
        mode = 'java';
        foldTextLength = foldTextLengthJava;
    } else if (language == 'csharp') {
        mode = 'csharp';
        foldTextLength = foldTextLengthCsharp;
    }
    if (problemType == 'Full') {
        editor.getSession().setMode("ace/mode/"+mode);
    } else {
        window.setTimeout(function() { 
            editor.getSession().addFold("...",new Range(1, 0, foldTextLength+1, 0)); 
        }, 100);
        editor.getSession().setMode("ace/mode/"+mode, function() {
            if (_range != null) {
                editor.getSession().removeMarker(_range.id);
            }
            _range = new Range(0, 0, foldTextLength+1, 0); // +5 is for prependTextPython and prependTextOther
            _range.id = editor.getSession().addMarker( _range, "ace_selection", "fullLine" );
            editor.getSession().addFold("...",new Range(1, 0, foldTextLength+1, 0));
        });
        editor.commands.addCommand({
            name: "blockLines",
            bindKey: {
                win: "Backspace|Enter|delete|tab|*",
                mac: "Backspace|Enter|delete|tab|\."
            },
            exec: function (editor, line) {
                var row = editor.selection.getCursor().row;
                if (row <= foldTextLength + 1) {
                    return true;
                }
                return false;
            },

        });
        editor.commands.addCommand({
            name: "blockBackspace",
            bindKey: {
                win: "Backspace",
                mac: "Backspace"
            },
            exec: function (editor, line) {
                var row = editor.selection.getCursor().row;
                var column = editor.selection.getCursor().column;
                if (row == foldTextLength + 2 && column == 0) {
                    return true;
                }
                return false;
            },

        });
        editor.commands.addCommand({
            name: "removeKey",
            bindKey: {
                win: "Ctrl-A",
                mac: "Command-A"
            },
            exec: function (editor, line) {
                return true;
            },

        });
    }
}

$(document).ready(function() {
    var langDropdown = document.getElementById('languageDropdown');
    var testArea = document.getElementById('testArea');
    var expectedArea = document.getElementById('expectedArea');
    ace.require("ace/ext/language_tools");
    editor.$blockScrolling = Infinity;
    editor.setOption("showPrintMargin",false);
    previousTheme = getPreviousTheme();
    editor.setTheme(themes[previousTheme]);
    $('.themes option:contains('+previousTheme+')').prop('selected', true);
    // Function to change sceen size of ace editor
    function toggleFullScreen() {
        var aceEditor = document.getElementById("editor");
        if (aceEditor.requestFullscreen) {
            aceEditor.requestFullscreen();
        } else if (aceEditor.msRequestFullscreen) {
            aceEditor.msRequestFullscreen();
        } else if (aceEditor.mozRequestFullScreen) {
            aceEditor.mozRequestFullScreen();
        } else if (aceEditor.webkitRequestFullscreen) {
            aceEditor.webkitRequestFullscreen();
        }
    }

    // invoke toggleFullScreen if user clicks on full screen button
    $("#zoom").click(function () {
        toggleFullScreen();
    }); 

    $(document).on('keyup',function(evt) {
        if (evt.keyCode == 27 && $(".screen-resize span").hasClass('glyphicon-resize-small')) {
            $(".mainRightDiv").insertAfter($(".editorTop"));
              $(".leftDiv").find($(".problemQuestion")).remove();
              $(".rightDiv").empty();
              $(".fullScreen").hide();
              $(".fullPageDiv").show();
              $("#full span").removeClass('glyphicon-resize-small');
              $("#full span").addClass('glyphicon-resize-full');
              $("body").css('overflow-x','auto');
      } else if(evt.keyCode == 27 && $( "body" ).hasClass( "fullScreen" ) ) {
            toggleFullScreen();
            e.preventDefault();
      }
  });

    $( ".screen-resize" ).click( function() {
       if ( $(window).width() > 768) {
          if ( $("#full span").hasClass('glyphicon-resize-full'))  {
            $(".leftDiv").append($(".problemQuestion").clone());
            $(".rightDiv").append($('.mainRightDiv'));
            $(".fullScreen").show();
            $(".fullPageDiv").hide();
            $("#full span").removeClass('glyphicon-resize-full');
            $("#full span").addClass('glyphicon-resize-small');
            $("body").css('overflow-x','hidden');
        } else if( $("#full span").hasClass('glyphicon-resize-small')) {
            $(".mainRightDiv").insertAfter($(".editorTop"));
            $(".leftDiv").find($(".problemQuestion")).remove();
            $(".rightDiv").empty();
            $(".fullScreen").hide();
            $(".fullPageDiv").show();
            $("#full span").removeClass('glyphicon-resize-small');
            $("#full span").addClass('glyphicon-resize-full');
            $("body").css('overflow-x','auto');
        }
      }
    });



    // reset editor
    $("#resetEditor").click (function() {
        if(confirm('Do you really want to reset your code in the editor?')){
            editor.getSession().setValue(defaultCode[language]);
            setEditorMode(language);
        }
    });

    // change theme
    $(".themeLight").parent().change(function(oEvent){
        var currentTheme = $(".themeLight").parent().val();
        switch(currentTheme){
            case "Theme Light":
                editor.setTheme("ace/theme/chrome");
                break;
            case "Dark":
                editor.setTheme("ace/theme/vibrant_ink");
                break;
            case "Monokai":
                editor.setTheme("ace/theme/monokai");
                break;
            case "GeeksforGeeks":
                editor.setTheme("ace/theme/gfg");
                break;
        }
    });

    // get local storage data
    var  storedCode = false;
    var  language = 'cpp';
    var testInput = '';
    var data = JSON.parse(localStorage.getItem( 'data' ));
    if( data !=null && data[pid] != null ){
        storedCode = data[pid].code;
        language = data[pid].lang;
      testInput = data[pid].testInput;
    }

    if(storedCode) {
        expectedArea.value = testInput;
        testArea.value = testInput;
        editor.session.setValue(storedCode);
        langDropdown.value=language;
        setEditorMode(language);
    } else {
        if (displayLang != null && displayLang != '') {
            langDropdown.value = displayLang;
        } else if (isDefaultCode && (defaultCode[def_lang]!='' && defaultCode[def_lang] != null) ) {
            if(def_lang == 'python')
                def_lang = 'python3';
            langDropdown.value = def_lang;
        } else {
            for(var key in defaultCode) {
                if( defaultCode[key] != null ) {
                    langDropdown.value = key;
                    break;
                }
            }
        }
        onChangeLanguageSelected();
    }


    document.getElementById("languageDropdown").onchange = function() {onChangeLanguageSelected()};
    function onChangeLanguageSelected() {
        saveEditorChanges();
        language = langDropdown.options[langDropdown.selectedIndex].value;
        previousLanguage = language;
        var data = JSON.parse(localStorage.getItem( 'data' ));
        if (data !=null && data[pid] != null && language == data[pid].lang ) {
            expectedArea.value = data[pid].testInput;
            editor.session.setValue(data[pid].code);
        } else {
            editor.getSession().setValue(defaultCode[language]);
        }
        setEditorMode(language);
    }

    $('#customInputCheckbox').click(function() {
        if ($(this).is(':checked')) {
            $("#customInputTestModal").modal();
        } 
    });

    $('#customInputTestModal').on('hidden.bs.modal', function () {
        $("#customInputCheckbox").click();
    })

    $("#run, #testRun, #expectedRun, #customInputTestRun, #customInputExpectedRun").click(function(e) {
        e.preventDefault();
        var requestType = $(this).attr('id');
        var data = {};
        var text = editor.getSession().getValue();
        var lines = text.split('\n');
        // remove one line, starting at the first position
        if(pid>700000)
            lines.splice(0,foldTextLength+2);
        // join the array back into a single string
        var code = lines.join('\n');
            
        data['problemId'] = pid;
        data['ptoken'] = $("#ptoken").text();
        if(requestType  == "run") {
            data['requestType'] = "solutionCheck";
            data['code'] = code; 
            data['language'] = language;
            data['track'] = track;
        } else if (requestType == "testRun" || requestType == "customInputTestRun") {
            data['requestType'] = "testSolution";
            if (requestType == "testRun") {
                data['input'] = sampleTestCases;
            } else {
                data['input'] = testArea.value;
                expectedArea.value = testArea.value;
            }
            data['code'] = code;
            data['language'] = language;
        } else if (requestType == "expectedRun") { 
                $("#customInputExpectedModal").modal();
                return;
        } else if (requestType == "customInputExpectedRun") {
            data['requestType'] = "expectedOutput";
            data['input'] = expectedArea.value;
            testArea.value = expectedArea.value;
        }

        $(this).attr( "disabled", "disabled" );
        $( ".out pre" ).text( 'Evaluating.....' );

        $.ajax({
            type:"POST",
            url:"/ajax/compilerRequest.php",
            data: data,
            dataType: "json",
            success:function(response){
                $(".out pre").html('');
                if(response.hasOwnProperty("errorMessage")) {
                    $( ".out pre" ).append( response['errorMessage'] );
                }
                else {
                    $( ".out pre" ).append( response['message'] );
                    var pattern = /Correct Answer/;
                    var result = pattern.test( response['message'] );
                    var metaInfo = (response.hasOwnProperty("metaInfo")?response['metaInfo']:false);
                    if(result && metaInfo == 'C') {
                        if (response['contestScore'] != '') {
                            $( ".out pre" ).append( "<br><pre>Your Current Contest Score: "+response['contestScore'] +"</pre>");
                            $("#contestScore").text(response['contestScore']);
                        }
                        if(response["status"] == 1 ) {
                            $('#problem' + pid).css({"color":" #808b96"});
                            $('#list' + pid).css({"border-left" : "3px solid #4cb96b"});
                        } else {
                            $('#problem' + pid).css({"color":" #808b96"});
                            $('#list' + pid).css({"border-left" : "3px solid #e63900"});
                        }
                    }
                    if( result ) {
                        clearInterval(problemTimer);
                    }
                    if(!result && data['requestType'] == "solutionCheck" && metaInfo!='C') {
                        if(response.hasOwnProperty("extraInfo")) {
                             $( ".out pre" ).append(response['extraInfo']);
                        } else {
                          $( ".out pre" ).append('<br/><input class="btn btn-sm btn-primary Help" value="Need Help?" style="border-radius:0.3rem;font-size: large;padding-right: 0px;padding-left: 0px;padding-top: 5px;padding-bottom: 5px;"></input>');
                        }
                    }

                    $('.Help').click(function() {
                        this.disabled=true;
                        $(".out pre").append('<br><ul><li>Generate URL of your code using <a href="https://ide.geeksforgeeks.org">ide.geeksforgeeks.org</a> and share in comments.</li>'+"<h4>OR</h4><li>Share this link in comments:<a href='/viewSol.php?subId="+response['id']+"&pid="+pid+"&user="+currentUser+"'>Link</a></li>"+"<h4>OR</h4><li>View Accepted  <a href='/problem_submissions.php?pid="+pid+"'>Solutions.</a></li>");
                    });
                 }   
            },
            error: function(jqXHR, exception, errorThrown) {
                $( ".out pre" ).text( 'Error / Run TimeError.\n Try again' );
                $( ".err" ).show().delay(5000).slideUp(200, function() {
                    $(this).hide();
                });
            },
            complete: function() {
                $("#customInputTestModal").modal('hide');
                $("#customInputExpectedModal").modal('hide');
                $("#"+requestType).removeAttr( "disabled" );
            }
        });
    });

    $('body').on('click', '#show-hints', function(event){
        event.preventDefault();
        $('#hintsModal').modal('show');
    });

    var unlockHintsAfterSoln=false;
    $('body').on('click', '.locked-hint-tab', function(event){
        
        var thisTab = $(this);
        $(thisTab).disabled=true;
        var hintNum = ($(thisTab).attr('id')).slice(1); //h1
        var thisHintText = $('#hint'+hintNum).text().trim();
        
        if( unlockHintsAfterSoln || confirm(thisHintText)){
            $.ajax({
                type: "POST",
                url: '/ajax/fetchSolutions.php',
                data: { problemId:pid, requestType:'fetchHints', utoken:$('#utoken').text(), uptoHint:hintNum},
                success: function(response) {

                        if(response['status'] == 'SUCCESS'){

                            var hints = JSON.parse(response['message']);

                            //update hints
                            for(var i in hints){
                               var j = parseInt(i)+1;
                               $('#hint'+j).html(hints[i]); 
                               $('#h'+j).removeClass('locked-hint-tab');
                               $('#h'+j).html($('#h'+j).html().replace('fa-lock', 'fa-unlock'));
                            }
                            PR.prettyPrint();
                        }
                        else{
                            showSnackbarMessage(response['message']);
                        }
                },
                error: function(jqXHR, exception, errorThrown) {
                            showSnackbarMessage('Some Error Occured');
                            $('#fullSoln').html(tempText);
                },
                complete: function(){
                    $(thisTab).disabled=false;
                    //$('#fullSolnTab').html($('#fullSolnTab').html().replace('spin fa-spinner', 'unlock'));
                }
        });

        }

    });

    fullSolutionFetched=false;
    $('body').on('click', '#fullSolnTab', function(event){
        //event.preventDefault();
        if(!fullSolutionFetched){
            if(confirm('If you see the full solution before solving the problem, then marks for this problem will not be added to your score.')){
                $('#fullSolnTab').html($('#fullSolnTab').html().replace('lock','spin fa-spinner'));
                var tempText = $('#fullSoln').html();
                $('#fullSoln').html('Fetching Solutions <span class="fa fa-spin fa-spinner"></span> ');
                $.ajax({
                    type: "POST",
                    url: '/ajax/fetchSolutions.php',
                    data: { problemId:pid, requestType:'allSolutions', utoken:$('#utoken').text()},
                    success: function(response) {

                            if(response['status'] == 'SUCCESS'){
                                $('#fullSoln').html(response['message']); //html 
                                $('.sol-tabs > li:first >a').trigger('click');  
                                //$('#fullSolnTab').html(' <i class="fa fa-unlock"></i> Full Solution');
                                //$('#fullSolnTab').html($('#fullSolnTab').html().replace('lock','unlock'));
                                fullSolutionFetched=true;
                                unlockHintsAfterSoln =true;
                                PR.prettyPrint();
                                $('ul.hint-tabs  li:nth-last-child(2) > a').trigger('click');
                                setTimeout(function(){$('#hintsModal .modal-body > .tab-content > div:nth-last-child(2)').removeClass('active in')}, 200);
                                //setTimeout(function(){$('ul.hint-tabs  li:nth-last-child(2) > a').trigger('click'); $('ul.hint-tabs  li:nth-last-child(2)').removeClass('active')}, 1200);
                                //setTimeout(function(){$('ul.hint-tabs  li:nth-last-child(2)').removeClass('active')}, 500);
                                //setTimeout(function(){$('#hintsModal > .tab-content  div:nth-last-child(2)').removeClass('active in')}, 500);
                            }
                            else{
                                showSnackbarMessage(response['message']);
                                $('#fullSoln').html(tempText);
                            }
                    },
                    error: function(jqXHR, exception, errorThrown) {
                                showSnackbarMessage('Some Error Occured');
                                $('#fullSoln').html(tempText);
                    },
                    complete: function(){
                        $('#fullSolnTab').html($('#fullSolnTab').html().replace('spin fa-spinner', 'unlock'));
                        setTimeout(function(){$('ul.hint-tabs  li:last-child > a').click()}, 10);
                    }
            });

            }
        }
    });

    function showSnackbarMessage(msg, duration=3000)
    {
        $('#gfg-snackbar').text(msg);
        $('#gfg-snackbar').addClass('show');
        setTimeout(function(){ $('#snackbar').removeClass('show'); }, duration);
    }

});

