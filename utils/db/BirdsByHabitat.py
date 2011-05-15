from BeautifulSoup import BeautifulSoup
import urllib2

habitat2url = {
    'coasts' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2075/Coasts/default.aspx',
    'deserts' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2077/Deserts/default.aspx',
    'forests' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2079/Forests/default.aspx',
    'grasslands' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2078/Grasslands/default.aspx',
    'lakes' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2076/Lakes,%20Rivers,%20Ponds/default.aspx',
    'marshes-swamps' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2081/Marshes,%20Swamps/default.aspx',
    'mountains' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2204/Mountains/default.aspx',
    'oceans' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2074/Oceans/default.aspx',
    'urban' : 'http://www.whatbird.com/browse/objs/All/birds_na_147/113/Habitat/2080/Urban/default.aspx'
}

if __name__ == "__main__":

    habitat2birds = {}

    for habitat, url in habitat2url.items():
        page = urllib2.urlopen(url)
        soup = BeautifulSoup(page)
        links = soup.findAll('a', attrs={'class':'ObjectLink'})
        links = [link.string for link in links]
        habitat2birds[habitat] = links

    f = open('habitat2birds.txt', 'w+')

    for habitat, birds in habitat2birds.items():
        f.write("%s:\n\t%s\n\n" % (habitat, "\n\t".join(birds)))           

    f.close() 
    
