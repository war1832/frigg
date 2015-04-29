CKEDITOR.editorConfig = function(config) {
  config.toolbar_Menu = [
    { name: 'clipboard', items: ['Source', 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo'] },
    { name: 'insert', items: ['Image', 'Table', 'HorizontalRule', 'Smiley'] },
    { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat'] },
    { name: 'colors', items: ['TextColor', 'BGColor'] },
    { name: 'styles', items: ['Format', 'Font', 'FontSize'] },
    { name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
    { name: 'links', items: ['Link', 'Unlink', 'Anchor'] }
  ];
  config.toolbar = 'Menu';
};
