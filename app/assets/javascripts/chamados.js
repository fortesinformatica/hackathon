$(function(){
	
	var contatos_temporarios = [];
	var clientes_temporarios = [];
	
	var verifica_cliente_implantacao = function(chamado_cliente){
		var id = $(chamado_cliente).val();
		var cliente = clientes_temporarios.filter(function(element){ return element.id == id })[0];
		var implantacao = ""
		if( cliente && cliente.implantacao) {
			implantacao = "Cliente Implantação";
		}

		$("#implantacao").html(implantacao);
	}
	
	var inicializarCampo = function(campo, valor){
	  if(window['formInitValues'] != undefined && valor){
      campo.val(valor);
      campo.change();          
    } 
	}
	
	
	if(window['formInitValues'] != undefined && formInitValues.cliente_id){
	  jQuery(document).ready(function($) {        
      $('.chzn-container').addClass('chzn-container-active');
      $('.chzn-drop .chzn-search input[type="text"]').keyup();
      $('#chamado_contato_id').focus();      
    })
  }
	
	$("#chamado_cliente_id").ajaxChosen({
	    method: 'GET',
	    url: '/clientes.json',
	    dataType: 'json',
		allow_single_deselect: true
	}, function (data) {
	  $("#chamado_cliente_id").html("");
	    var terms = {};
		clientes_temporarios = data;
	    $.each(data, function(i, cliente) {
	        terms[cliente.id] = cliente.nome;
	    });
	    
	    success = function(){
	       inicializarCampo($("#chamado_cliente_id"), formInitValues.cliente_id);  
         $("#chamado_cliente_id").trigger("liszt:updated");
	    }
	    return terms;
	});
	
	$("#chamado_cliente_id").change(function() {		
		$("#email").val("");		
		verifica_cliente_implantacao(this);	
		
		$.get("/clientes/" + $(this).val() + "/sistemas/por_cliente.json", function(sistemas) {
			$("#chamado_sistema_id").addOptions(sistemas, { text:"nome" });
			//$("#chamado_sistema_id").prepend( $("<option>").html("Selecione um sistema...") );
		});
		
		$.get("/clientes/" + $(this).val() + "/contatos/por_cliente.json", function(contatos) {
			contatos_temporarios = contatos;
			
			$("#chamado_contato_id").addOptions(contatos, { 
				before: function() {
					this.append( $("<option>").html("Selecione um contato...") );
				},
				text:"user.nome" 
			});
			
			$('#chamado_sistema_id').change();
			inicializarCampo($("#chamado_contato_id"), formInitValues.contato_id);			    
		});
	});
	
	$("#chamado_contato_id").change(function() {
		var id = $(this).val();
		var contato = contatos_temporarios.filter(function(element){ return element.id == id })[0];
		if( contato ) $("#email").val(contato.user.email);
	});

	$("#chamado_sistema_id").change(function() {
		var id = $(this).val();
		$.get("/clientes/" + $("#chamado_cliente_id").val() + "/sistemas/ " + id + "/contrato.json", function(contrato) {
			$("#horas_contratadas").html(contrato.tempo_contratado_fmt);
			$("#horas_usadas").html(contrato.tempo_usado_fmt);
			$("#horas_saldo").html(contrato.tempo_restante_fmt);
		});
	});
});
