names = $(addprefix _layouts/,default post) index
hss = $(addsuffix .hs,$(addprefix html-build/,$(names)))
hss_dirs = $(sort $(dir $(hss)))
htmls = $(addsuffix .html,$(addprefix src/,$(names)))


all: site

clean:
	rm -rf html-build
	rm -f $(htmls)

$(htmls): src/%.html: html-build/%.hs html-src/%.meta
	(cat html-src/$*.meta; echo; runghc $<) >$@

$(hss): html-build/%.hs: html-src/%.hs_ | $(hss_dirs)
	./genhs.bash $< >$@

$(hss_dirs):
	mkdir -p $@

site: $(htmls)
	jekyll build

serve: site
	jekyll serve
