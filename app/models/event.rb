class Event < ActiveRecord::Base
  def self.fetch! stream=nil
    stream ||= Github.public_events

    stream.each do |gev|
      Event.
        where(github_id: gev.id).
        create_with(github_data: hashify(gev)).
        first_or_create!
    end
  end

  def self.of_type t
    where("github_data->>'type' = ?", "#{t.camelize}Event")
  end

  def self.for_repo repo_name
    where("github_data->'repo'->>'name' = ?", repo_name)
  end

private

  # This is a gross hackc because GithubEvent#to_json doesn't
  #   produce the right kind of nested JSON (arrays instead of hashes)
  #   and this does the right thing. Please don't hold this against
  #   Postgres.
  def self.hashify value
    if value.is_a? Array
      value.map { |v| hashify v }
    else
      h = value.to_h
      h.each { |k,v| h[k] = hashify v }
      h
    end
  rescue StandardError
    value
  end

end
