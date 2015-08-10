class Client
  attr_reader :email, :name, :curriculum, :cpf

  def self.build
    self.new email: nil, name: nil
  end

  def initialize email: , name:, curriculum: nil, cpf: nil
    @email = email
    @name  = name
    @cpf   = cpf
    @curriculum = curriculum
  end

  def save
    valid? and save_curriculum
  end

  def to_s
    "#{ email }_#{ cpf.to_s.gsub(/[^0-9]/, '') }"
  end

  def valid?
    not( email.to_s.empty? or name.to_s.empty? )
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
