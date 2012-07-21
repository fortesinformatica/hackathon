Ext.define('Ext.ux.Cronometro', {
	extend: 'Ext.container.Container',
		
	criarCronometro: function() {
		var self = this;
		var progressbar = this.getProgressBar();
		this.cronometro = StopWatch( function(data){
			progressbar.updateProgress(self.count);
			self.count += self.tamanhoPedaco;
			if(data.minutes == Math.round(self.marca / 60) )  progressbar.addCls("aviso");				
			progressbar.updateText(data.text);
		});
	},
	criarCronometroEditavel: function() {
		var cronometroEditavelContainer = this.getCronometroEditavelContainer();
		this.cronometroEditavel = StopWatch( function(data){
			cronometroEditavelContainer.update(data.text);
		});
	},
	
	atualizarCronometroEditavel: function (value) {
		this.cronometroEditavel.update(value);
		this.getCronometroEditavelContainer().update( this.cronometroEditavel.getValue() );
	},
	
	finalizarEdicao: function(event, element) {
		this.atualizarCronometroEditavel(element.value);
	},
	
	mensagemTempoIncorreto: function() {
		Ext.Msg.show({
		    msg: 'Tempo informado está incorreto',
		    buttons: Ext.Msg.OK
		});
	},
	
	validarInput: function(event, input){
		var valido = new RegExp(/^[0-9]{2}:[0-5][0-9]:[0-5][0-9]$/g).test( input.value );
		if(!valido) {
			this.atualizarCronometroEditavel("00:00:00");
			this.mensagemTempoIncorreto();
		}
	},
	
	criarInput: function(value, container, callback) {
		var id = Ext.id();
		var style = "position: relative;top:-3px;border:0;width:" + container.el.getWidth() + "px;";
		var input = "<input type='text' id='"+id+"' style='"+style+"' value="+value+" />";
		container.update(input);
		var validacao = Ext.Function.createSequence(callback, this.validarInput, this);
		Ext.get(id).addListener("blur", validacao, this).focus();
		$("#"+id).mask("99:99:99")
				 .keypress(function(e) { if(e.which == 13) return false; });
	},
	
	editarCronometroEditavel: function() {
		this.cronometroEditavel.pause();
		var cronometroEditavelContainer = this.getCronometroEditavelContainer();
		var value = cronometroEditavelContainer.html;
		this.criarInput(value, cronometroEditavelContainer, this.finalizarEdicao);
	},
		
	getProgressBar: function() { return this.items.first();	},
		
	getCronometroEditavelContainer: function() {
		return this.items.get(1).items.first();
	},
		
	atualizarCronometros: function() {
		this.cronometroEditavel.track();
		this.cronometro.track();
	},
		
	iniciar: function() {
			
		this.criarCronometro();
		this.criarCronometroEditavel();
			
		var runner = new Ext.util.TaskRunner();
		var tempoTramite = runner.newTask({run: this.atualizarCronometros, interval: 1000, scope: this});
		tempoTramite.start();
			
	},
		
	initComponent : function(config) {

		var tma = 6 * 60; //100%
		var limite = 90; //90%
		var marca = tma * limite / 100
		var tamanhoPedaco = 1 / tma;
		var count = tamanhoPedaco;
			
		this.marca = marca;
		this.tamanhoPedaco = tamanhoPedaco;
		this.count = count;

		this.items = [ 
			{ xtype: 'progressbar'}, 
			{
				bodyCls: "cronometroBase",
				layout: "hbox",
				height: 35,
				items: [
					{
						html: "00:00:00",
						bodyCls: "cronometro",
						listeners: {
							afterrender: {
								fn: function(componente) {
									componente.el.addListener("dblclick", this.editarCronometroEditavel, this);
								},
								scope: this
							}
						},
						margins: {
							right: 10
						}
					},
					{
						xtype: 'button', 
						iconCls: "icon-pause",
						height: 30,
						width: 33, 
						handler: function() { this.cronometroEditavel.pause()  },
						scope: this
						, margins: { right: 2 }
					},
					{
						xtype: 'button', 
						iconCls: "icon-play",
						height: 30,
						width: 30,
						handler: function() { this.cronometroEditavel.start()  },
						scope: this
					}
						
				]
			}
		];
		this.listeners = {	afterrender : this.iniciar	};
		this.callParent(config);
    }
});