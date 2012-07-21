(function ($) {

	var getValue = function(object, property) {
		return (function roam(property, objeto) {
		    var hierarchy = property.split(".");
		    objeto = objeto[ hierarchy.shift() ];
		    return (hierarchy.length > 0 && typeof objeto !== "undefined")?
		        roam(hierarchy.join("."), objeto) : objeto
		})(property, object);
	};

    $.fn.extend({
    	addOptions: function(collection, config) {
			
			var self = $(this).html("");
			var value = (config && config.value)? config.value : "id";
			var text  = (config && config.text)?  config.text  : "name";
			
			if( config && typeof config.before === "function") config.before.call(this);
			
			$.each(collection, function(index, item){
				self.append( 
					$("<option>", { 
						value : getValue(item, value) 
					}).html( getValue(item, text) ) 
				);
			});
			
			if( config && typeof config.after === "function") config.after.call(this);			
			
    		return this;
    	}
    })
	
})(jQuery);