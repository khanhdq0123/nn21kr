$.validator.addMethod('filesize', function(value, element, param) {
	try {
		return this.optional(element) || (element.files[0].size <= param)
	} catch(e) {
		return this.optional(element) || true;
	}
});

$.validator.addMethod('image', function(value, element) {
	
	if(element.files.length < 1) {
    	return true;
	} else {
		filename = element.files[0].name;
	    return this.optional(element) || (/\.(gif|jpg|jpeg|tiff|png)$/i).test(filename);
	}
});