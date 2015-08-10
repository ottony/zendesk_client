class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def initialize dir, new_filename = nil
    @dir = dir
    @new_filename = new_filename
  end

  def store_dir
    File.join File.expand_path( Dir.pwd ), 'public/uploads', dir
  end

  def filename
    @new_filename || original_filename
  end

  def filename= new_name
    @new_filename = new_name
  end

  private

  def dir
    @dir
  end
end
