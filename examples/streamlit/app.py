import streamlit as st
import os

# --- PAGE CONFIGURATION ---
# This sets the title of the browser tab and the icon
st.set_page_config(page_title="My Streamlit App", page_icon="🚀")

# --- LOADING SECRETS ---
# Streamlit has a built-in way to handle secrets. 
# Locally, it reads from .streamlit/secrets.toml
# On Streamlit Cloud, you paste them into the 'Secrets' box in settings.
try:
    openai_key = st.secrets["OPENAI_API_KEY"]
except Exception:
    openai_key = "Not Found"

# --- MAIN UI ---
st.title("Welcome to my AI App")
st.write("This is a template for a best-practice Streamlit application.")

# Sidebar for inputs
with st.sidebar:
    st.header("Settings")
    user_name = st.text_input("What is your name?", "Explorer")
    model_choice = st.selectbox("Choose a model", ["GPT-4o", "GPT-4o-mini", "Gemini Pro"])

# Main content area
st.header(f"Hello, {user_name}!")
st.info(f"You have selected the {model_choice} model.")

if st.button("Click Me"):
    st.balloons()
    st.success("Great job! Your first Streamlit button works.")

# Displaying data
st.header("Sample Data Display")
import pandas as pd
data = pd.DataFrame({
    'Project': ['GoldenClue', 'IB_Abel', 'SamplePro'],
    'Status': ['Live', 'Live', 'Beta']
})
st.table(data)

# Showing secret status (Never show real keys in production!)
if openai_key != "Not Found":
    st.write("✅ API Key is configured correctly.")
else:
    st.warning("⚠️ API Key is missing. Check your secrets.toml file.")
