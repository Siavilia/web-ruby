$('#modalEditWindow').on('shown.bs.modal', function () {
  $('#myInput').trigger('focus')
})



// $('#btn_edit').on("click", function() { 
//     console.log('click ok');
//     //let valuesToSubmit = $(this).serialize();
//     $.ajax({
//       type: "POST",
//       url: $(this).attr('href'), //sumbits it to the given url of the form
//       //data: valuesToSubmit,
//       dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
//       success: function(data){
//         console.log('submit');
//         $('#edit_form').html = '<%= j(render partial: 'modal')  %>'
//       },
//       error: function() {console.log("error");}
//     });
// }); %>
// console.log('submit');
// $('#edit_form').html = '<%= j(render partial: 'modal')  %>'