class Client
  attr_reader :email, :name, :curriculum, :cpf, :curriculum_file

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
    stored   = uploader.store! curriculum

    Zendesk.create_ticket client: self, download_path: download_path

    stored
  end

  def download_path
    File.join Config.domain, curriculum_version 
  end

  def curriculum_version
    return @curriculum_version unless curriculum

    @curriculum_version ||= "#{ name.to_s.gsub(/\s/, '_') }-#{ Time.now.strftime('%d_%m_%Y-%H_%M_%S') }.#{ curriculum.path[/[^\.]+$/] }"
  end
end
