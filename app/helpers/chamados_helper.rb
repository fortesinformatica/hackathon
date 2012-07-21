module ChamadosHelper
  def atendente_logado
    Atendente.where(:user_id => current_user).first
  end
end
