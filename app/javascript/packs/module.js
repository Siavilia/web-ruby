document.addEventListener("DOMContentLoaded", function() {
    // delete object
    $('.delete').on('click', function(){//$('.delete').on('click', function(){
        if (confirm("Are you sure?")) {
            let elem = $(this).closest('article');
            elem.fadeOut(500, function(){ elem.remove();});
            console.log('success');
        }
            else {
                console.log('ajax error');
            }
            console.log('end');
        })
    console.log('start'); 
})
//"turbolinks:load"