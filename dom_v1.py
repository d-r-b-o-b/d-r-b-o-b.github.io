import dominate
from dominate.tags import *
import os
import pandas as pd
import math
import re

DIR_NAME = "/Users/bob/GaTech Dropbox/Robert Wilson/Website/2025_v2/dominate/"

PUB_FILE = "/Users/bob/GaTech Dropbox/Robert Wilson/Website/2025_v2/data/google_scholar_publications_labels.xlsx"

def make_navigation(doc):
    with div(cls="center-links"):
        
        p(
            a("Research",href="index.html"), 
            " | ", 
            a("People",href="people.html"), 
            " | ", 
            a("Publications",href="publications.html"), 
            # " | ", 
            # a("Resources",href="resources.html"), 
            
        )
        
    return doc

def start_doc(doc_name):
    doc = dominate.document(title=doc_name)
    with doc.head:
        link(rel='stylesheet', href='style.css')
        script(type='text/javascript', src='script.js')

    return doc

def dom_write(fname, doc):
    os.chdir(DIR_NAME)
    with open(fname, 'w') as f:
        f.write(doc.render())

def dom_open(fname):
    os.chdir(DIR_NAME)
    os.system(f"open {fname}")

def make_person(name, job, pic, link):
    with div():
        attr(cls="person")
        a(img(src=f"./people/{pic}", alt=f"{name}"), href=link)
        
        with div():
            attr(cls="overlay")
            with div():
                attr(cls="text")
                p(f'{name}')
                p(f'{job}')

def make_people():
        
    doc = start_doc('People')

    with doc:
        with div():
            attr(cls="container")
            
            make_navigation(doc)
            h1('People')
        
            with div(cls='center-quote'):
                p('Meet the NRDs!')
            
            h3('Current lab members')
            with div():
                attr(cls="people-container")
                
                make_person('Bob Wilson', 'PI', 'Bob_small4.png', 'https://d-r-b-o-b.github.io/')
                make_person('Caroline Phelps', 'postdoc', 'Caroline.jpg', '')
                make_person('Hanbo Xie', 'grad student', 'Hanbo.jpg', '')
                make_person('Huadong Xiong', 'grad student', 'Huadong.jpg', '')
                make_person('Jingming Xue', 'grad student', 'Jim.jpg', '')
                make_person('Yinqi Huang', 'grad student', 'Yinqi.jpeg', '')
              
            h3('Alumni')
            with div():
                attr(cls="people-container")
            
                make_person('Jane Keung', 'postdoc', 'JaneKeung.jpg', '')
                make_person('Sarah Cook', 'grad student', 'Sarah.jpg', '')
                make_person('Siyu Wang', 'grad student', 'Siyu.png', '')
                make_person('Hashem Sadeghiyeh', 'grad student', 'Hashem.png', '')
                make_person('Bryan Kromenacker', 'grad student', 'BryanKromenacker.jpg', '')
                make_person('Jack-Morgan Mizell', 'grad student', 'JackMorgan.jpg', '')
                make_person('Skyler Wyly', 'research assistant', 'Skyler.jpg', '')
                
                
    dom_write('people.html', doc)
    dom_open('people.html')
                            
def make_research():
        
    doc = start_doc('Research')

    with doc:
        with div():
            attr(cls="container")
            make_navigation(doc)
            h1('Research')
        
            
            # with div():
            #     attr(cls='center-image')
            #     img(src="./pics/WaterFatAndSalt.png", alt="Brain = Water + Fat + Salt")

            with div():
                attr(cls='brain_equation_container')
                p('🧠 🟰 💧 ➕ 🧈 ➕ 🧂')

            p('How can you build a computer out of water and fat and salt? What does that mean for the kinds of cognitive computations the brain can perform? And how would such a computer change with age, cognitive decline, or mental illness? In the NRDlab, we try to address these questions by building computational models of cognition and by running behavioral, neuroimaging and neurostimulation experiments.')

            h3("How do we decide between exploration and exploitation?")

            p("When you go to a favorite restaurant do you always order the same thing or do you try something new? This simple conundrum, deciding between what you know and what you don't, is at the heart of the explore-exploit dilemma and whether it's a cow looking for greener pastures or a human looking for love, this problem is ubiquitous and important to solve. Work in the NRDlab investigates the neural computations underlying the explore-exploit decisions in humans across the lifespan. ")

            p('For more information hit the "explore-exploit" button on our', a('Publications', href="publications.html"), ' page')

            h3('Why do we make mistakes?')

            p('We all make mistakes.  This work asks "Why?" Do mistakes simply reflect the difficulty of building a computer out of salt, water and fat?  Or can mistakes actually be useful, and usefully regulated?')

            p('For more information hit the "behavioral variability" button on our', a('Publications', href="publications.html"), ' page.')  


            h3('Phishing email detection')
            p('Phishing emails are a major public health problem, linked to negative health outcomes due to fraud and exploitation. Because of their sheer volume, and because phishing emails are designed to deceive, purely technological solutions can only go so far, leaving human judgment as the last line of defense. In this project we are probing the cognitive and neural processes underlying how people decide whether an email is safe or not.')

            p('For more information hit the "phishing" button on our', a('Publications', href="publications.html"), ' page')


    dom_write('index.html', doc)
    dom_open('index.html')

def extract_surnames(author_string):
    # Regular expression to match the surnames
    pattern = r'\b\w+\b(?=\s*and|\s*$)'
    
    # Find all matches
    surnames = re.findall(pattern, author_string)
    
    # Check if 'Wilson' is in the deleted names
    if len(surnames) == 1:
        formatted_surnames = surnames[0]
    elif 'Wilson' in surnames[3:-1]:
        formatted_surnames = ', '.join(surnames[:3]) + ', ..., Wilson, ..., ' + surnames[-1]
    elif len(surnames) > 4:
        formatted_surnames = ', '.join(surnames[:3]) + ', ..., ' + surnames[-1]
    else:
        formatted_surnames = ', '.join(surnames[:-1]) + ' and ' + surnames[-1]
    
    return formatted_surnames

def make_pub_buttons(df):
    

    start_index = df.columns.get_loc('Abstract') + 1
    labels = df.columns[start_index:]
    with button(cls='btn active', onclick=f"filterSelection('all')"):
        p('All')

    for label in labels:
        dum = label.replace(" ", "")
        with button(cls=f'btn {dum}', onclick=f"filterSelection('{dum}')"):
            p(label)

    
    # <button class="btn" onclick="filterSelection('misc')"> miscellaneous</button>

def make_pubs(df):
    start_index = df.columns.get_loc('Abstract') + 1
    labels = df.columns[start_index:]
    
    with div(cls='pub_container'):
        for ind in range(0, len(df)):


            # go through each row of df
            # check which labels are active
            # add those labels to the div class name
            s = 'filterDiv'
            for j in range(0, len(labels)):
                if not(math.isnan(df.iloc[ind,start_index+j])):
                    s = s + ' ' + labels[j].replace(" ", "")
                    print(s)

            
            with div(cls=s):
                with div(cls="pub"):
                    a(df['Title'][ind], href=df['Link'][ind], cls='pub_title')
                    p(
                        f"{extract_surnames(df['Authors'][ind])} ({df['Year'][ind]})", cls='pub_names' )
                    if type(df['Journal'][ind]) is str:
                        p(f"{df['Journal'][ind]}", cls='pub_journal')
                    # with div(cls='overlay'):
                    #     with div(cls="text"):
                    #         pass
            
def make_publications():
        
    doc_name = 'Publications'
    doc = start_doc(doc_name)

    with doc:

        with div():
            attr(cls="container")
            make_navigation(doc)
            h1(doc_name)

            with div(cls='center-quote'):
                p('Click a button to filter by research area')


            df = pd.read_excel(PUB_FILE)
            with div(cls="center-buttons", id="myBtnContainer"):
                make_pub_buttons(df)
            make_pubs(df)   


   
    dom_write(f'{doc_name.lower()}.html', doc)
    dom_open(f'{doc_name.lower()}.html')

def make_resources():
        
    doc_name = 'Resources'
    doc = start_doc(doc_name)

    with doc:
        with div():
            attr(cls="container")
            make_navigation(doc)
            h1(doc_name)
   
    dom_write(f'{doc_name.lower()}.html', doc)
    dom_open(f'{doc_name.lower()}.html')

make_people()
make_research()
make_publications()
make_resources()

