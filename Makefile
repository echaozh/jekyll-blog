names = $(addprefix _layouts/,default post tag) index \
		$(addprefix resumes/,resume)
hss = $(addsuffix .hs,$(addprefix html-build/,$(names)))
hss_dirs = $(sort $(dir $(hss)))
htmls = $(addsuffix .html,$(addprefix src/,$(names)))
htmls_dirs = $(sort $(dir $(htmls)))


all: site

clean:
	rm -rf html-build
	rm -f $(htmls)
	rm -rf _site

$(htmls): src/%.html: html-build/%.hs html-src/%.meta | $(htmls_dirs)
	(cat html-src/$*.meta; echo; runghc $<) >$@

$(hss): html-build/%.hs: html-src/%.hs_ | $(hss_dirs)
	./genhs.bash $< >$@

$(htmls_dirs):
	mkdir -p $@

$(hss_dirs):
	mkdir -p $@

site: $(htmls)
	jekyll build

serve: site
	jekyll serve --watch
