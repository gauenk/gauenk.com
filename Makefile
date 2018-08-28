DOCS=index bio papers software book_solutions

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix html/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	cp -r html/* /home/gauenk/Documents/gauenk.github.io
	rsync -aur -e 'ssh -p 5000' html/* gauenk@pu:/var/www/gauenk.com/public_html/
	rsync -aur -e 'ssh -p 5000' html/imgs/* gauenk@pu:/var/www/gauenk.com/public_html/imgs/
	@echo ' done.'

html/%.html : %.jemdoc MENU
	jemdoc -o $@ $<

.PHONY : clean
clean :
	-rm -f html/*.html
