# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver import Chrome, ChromeOptions
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

opts = ChromeOptions()
opts.add_argument("--window-size=2560,1440")

class T2(unittest.TestCase):
    def setUp(self):
        self.driver = Chrome(options=opts)
        self.driver.implicitly_wait(30)
        self.base_url = "https://www.google.com/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_t2(self):
        driver = self.driver
        # Connexion
        driver.get("https://opensource-demo.orangehrmlive.com/web/index.php/auth/login")
        driver.find_element(By.NAME,"username").click()
        driver.find_element(By.NAME,"username").clear()
        driver.find_element(By.NAME,"username").send_keys("Admin")
        driver.find_element(By.NAME,"password").clear()
        driver.find_element(By.NAME,"password").send_keys("admin123")
        driver.find_element(By.XPATH,"//button[@type='submit']").click()

        # Ajout Candidat
        driver.get("https://opensource-demo.orangehrmlive.com/web/index.php/recruitment/viewCandidates")

        # Enregistrez le contenu de la liste avant l'ajout de l'élément
        candidat_list_before_add = driver.find_elements(By.CSS_SELECTOR, ".oxd-table-card")
        # candidat_list_before_add = driver.find_elements(By.CLASS_NAME, "oxd-table-card")

        driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div[2]/div/button").click()
        driver.get("https://opensource-demo.orangehrmlive.com/web/index.php/recruitment/addCandidate")
        driver.find_element(By.NAME,"firstName").click()
        driver.find_element(By.NAME,"firstName").clear()
        driver.find_element(By.NAME,"firstName").send_keys("John")
        driver.find_element(By.NAME,"middleName").click()
        driver.find_element(By.NAME,"middleName").clear()
        driver.find_element(By.NAME,"middleName").send_keys("john")
        driver.find_element(By.NAME,"lastName").click()
        driver.find_element(By.NAME,"lastName").clear()
        driver.find_element(By.NAME,"lastName").send_keys("John")
        driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/form/div[3]/div/div/div/div[2]/input").click()
        driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/form/div[3]/div/div/div/div[2]/input").clear()
        driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/form/div[3]/div/div/div/div[2]/input").send_keys("d@d.fr")
        driver.find_element(By.XPATH,"//button[@type='submit']").click()
        driver.find_element(By.LINK_TEXT,"Candidates").click()
        driver.get("https://opensource-demo.orangehrmlive.com/web/index.php/recruitment/viewCandidates")

        # Attendre un court instant pour permettre à la liste de se mettre à jour
        time.sleep(1)

        # Enregistrez le contenu de la liste apres l'ajout de l'élément
        candidat_list_after_add = driver.find_elements(By.CSS_SELECTOR, ".oxd-table-card")

        # # Vérifier que l'élément a bien été ajouté à la liste
        assert len(candidat_list_before_add) < len(candidat_list_after_add), "L'élément n'a pas été ajouté à la liste"

        # Suppression Candidat
        
        # Enregistrez le contenu de la liste avant la suppression de l'élément
        candidat_list_before_delete = driver.find_elements(By.CSS_SELECTOR, ".oxd-table-card")

        driver.find_element(By.XPATH,"//div[@class='oxd-table-card']/div[@class='oxd-table-row oxd-table-row--with-border'][1]/div[@class='oxd-table-cell oxd-padding-cell'][7]/div[@class='oxd-table-cell-actions'][1]/button[@class='oxd-icon-button oxd-table-cell-action-space'][2]").click()
        driver.find_element(By.XPATH,"//div[@id='app']/div[3]/div/div/div/div[3]/button[2]").click()

        # Attendre un court instant pour permettre à la liste de se mettre à jour
        time.sleep(1)

        # Enregistrez le contenu de la liste apres la suppression de l'élément
        candidat_list_after_delete = driver.find_elements(By.CSS_SELECTOR, ".oxd-table-card")

        # Vérifier que l'élément a bien été supprime de la liste
        assert len(candidat_list_before_delete) > len(candidat_list_after_delete), "L'élément n'a pas été supprimé de la liste"

        # Recherche Candidat par son nom
        # driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/div[2]/form/div[2]/div/div/div/div[2]/div/div/input").click()
        # driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/div[2]/form/div[2]/div/div/div/div[2]/div/div/input").clear()

        # driver.find_element(By.XPATH,"//div[@id='app']/div/div[2]/div[2]/div/div/div[2]/form/div[2]/div/div/div/div[2]/div/div/input").send_keys("maurice  betoun betoun")
        # driver.find_element(By.XPATH,"//button[@type='submit']").click()

        # candidat_list_search = driver.find_elements(By.CSS_SELECTOR, ".oxd-table-card")

        # Vérifier que l'élément est bien dans la liste
        # assert len(candidat_list_search) >= 1, "L'élément n'a pas été trouvé dans la sélection"

    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
