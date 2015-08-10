class Client
  attr_reader :email, :name, :curriculum, :cpf

  def initialize email: , name:, curriculum: nil, cpf: ''
    @email = email
    @name  = name
    @cpf   = cpf
    @curriculum = curriculum
  end

  def save
    save_curriculum
  end

  def to_s
    "#{ email }_#{ cpf.gsub(/[^0-9]/, '') }"
  end

  private

  def save_curriculum
    return true unless curriculum

    uploader = FileUploader.new to_s, curriculum_version
    file     = File.open( curriculum ) if curriculum.kind_of? String
    file   ||= curriculum

    uploader.store! file
  end

  def curriculum_version
    "#{ name } - #{ Time.now.strftime('%Y-%m-%d_%H:%M:%S') }"
  end
end
