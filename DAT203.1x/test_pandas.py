import pandas as pd
import os
import matplotlib.pyplot as plt

file_name = "WorldBank_GDP_perCapita.csv"
path_txt = "G:\_Appoggio\JRC WFP\SPARC\SpaRC_Cyclones\Vulnerability_Data"

path = os.path.join(path_txt,file_name)
frame = pd.read_csv(path)

# print(frame.head())

out = frame[['Country Name','Country Code']]
print out.head()

frame1 = frame["Country Code"][1:3]
print frame1

# plt.plot(frame)

