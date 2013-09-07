module Jekyll

  class TagPage < Page
    def initialize(site, base, dir, tag, tagged)
      @site = site
      @base = base
      @dir = dir
      @name = "#{tag}.html"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['title'] = "Posts tagged \"#{tag}\""
      self.data['tag'] = tag
      self.data['tagged'] = tagged
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        dir = "tags"
        site.tags.keys.each do |tag|
          site.pages << TagPage.new(site, site.source, dir, tag, site.tags[tag])
        end
      end
    end
  end

end
