function readURL(input) {

  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('#avatar').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

$('#user_picture').change(function() {
  readURL(this);
});

$('#user_picture').bind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert(I18n.t('users.action.maximum_size_err'));
  }
});
