class MarkdownHelper

  def self.markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       false,
      space_after_headers: true,
      link_attributes: { rel: 'nofollow', target: '_blank' }
    }
    extensions = {
      autolink: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      tables: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    @markdown = Redcarpet::Markdown.new(renderer, extensions)
    @markdown.render(text).html_safe
  end
end
