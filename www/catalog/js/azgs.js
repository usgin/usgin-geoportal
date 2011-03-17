$(document).ready(function()
{
   $('#mdEditor\\:identification_date').mask('9999-99-99T99:99:99');
   $('#mdEditor\\:general_datestamp').mask('9999-99-99T99:99:99');
   //$('#mdEditor\\:general_datestamp').mask('9999-99-99');
      
   $('#mdEditor').submit(function()
   {
      var fileIdent = $('#mdEditor\\:general_fileIdentifier').val();
      if (fileIdent[0] == "{")
      {
         fileIdent = fileIdent.substring(1, fileIdent.length);
      }
      if (fileIdent[fileIdent.length - 1] == "}")
      {
         fileIdent = fileIdent.substring(0, fileIdent.length - 1);
      }
      $('#mdEditor\\:general_fileIdentifier').val(fileIdent);      
   });

   $("#text").val(function(i, val) 
   {
       return val.replace('.', ':');
   });

   // Strip the curly brackets from the uuid
   var uuid = $('#mdEditor\\:general_fileIdentifier').val();
   uuid = uuid.replace('{', '')
   uuid = uuid.replace('}', '')
   $('#mdEditor\\:general_fileIdentifier').val(uuid);

});
