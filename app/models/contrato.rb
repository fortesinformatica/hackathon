class Contrato < ActiveRecord::Base
  attr_accessible :tempo_contratado
  
  belongs_to :sistema
  belongs_to :cliente
  belongs_to :tipo_contrato
  
  def tempo_contratado_fmt
    seconds_to_hhmmss tempo_contratado
  end
  
  def tempo_usado
    tramites = Tramite.where(:chamado_id => Chamado.where(:sistema_id => sistema, :cliente_id => cliente))
    tramites.inject(0){ |x,y| x + y.tempo_cobrado }
  end

  def tempo_usado_fmt
    seconds_to_hhmmss tempo_usado
  end

  def tempo_restante
    tempo_contratado - tempo_usado
  end

  def tempo_restante_fmt
    seconds_to_hhmmss tempo_restante
  end

private
  def seconds_to_hhmmss seconds
    if seconds < 0
      "00:00:00" 
    else
      Time.at(seconds).gmtime.strftime('%R:%S')
    end
  end
end
