function StopWatch( callback ) {
	var seg = 1, hora = 0, min = 0, paused = false;

	var leftPad = function(string, size, character) {
        var result = String(string);
        character = character || " ";
        while (result.length < size) {
            result = character + result;
        }
        return result;
    };
	
	var _getValue = function() {
		var formatada = "##:##:##".replace(/(##)/g, function(a, b, index){ 
			switch(index) {
				case 0: return leftPad(hora, 2, '0');
				case 3: return leftPad(min, 2, '0');
				case 6: return leftPad(seg, 2, '0');
			} 
		});
		return formatada;
	};

	var _track = function() {
		var formatada = "";
		if(!paused) {
			if(seg == 60) {  min++; seg = 0; }
			if(min == 60) { hora++; min = 0; }
			formatada = _getValue();
			callback({
				hours: hora,
				minutes: min,
				seconds: seg,
				text: formatada
			});
			seg++;				
		}
		return {
			hours: hora,
			minutes: min,
			seconds: seg,
			text: formatada
		};
	};
	
	var _update = function(value) {
		if(typeof value === "string") {
			values = value.split(":");
			hora = values[0];
			min  = values[1];
			seg  = values[2];
		}
	};
	
	var _getTimeInSeconds = function() {
		return Number( Number(hora * 3600) + Number(min * 60) + Number(seg) );
	};
	
	return {
		track: _track,
		pause: function() { paused = true; },
		start: function() { paused = false; },
		update: _update,
		getValue: _getValue,
		getTimeInSeconds: _getTimeInSeconds
	};
};
