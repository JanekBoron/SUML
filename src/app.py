import os
import datetime
from dotenv import load_dotenv
import streamlit as st
import openai
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobClient

# Wczytaj zmienne środowiskowe
dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
load_dotenv(dotenv_path)

# OpenAI API
openai.api_key = os.getenv("OPENAI_API_KEY")

# Azure Blob Storage ustawienia
AZURE_STORAGE_ACCOUNT_URL = os.getenv("AZURE_STORAGE_ACCOUNT_URL")
LOG_CONTAINER = os.getenv("LOG_CONTAINER", "logs")
credential = DefaultAzureCredential()

def upload_to_blob(path: str, data: bytes):
    blob = BlobClient(
        account_url=AZURE_STORAGE_ACCOUNT_URL,
        container_name=LOG_CONTAINER,
        blob_name=path,
        credential=credential,
    )
    blob.upload_blob(data, overwrite=True)

# Konfiguracja Streamlit
st.set_page_config(page_title="Asystent Snu", layout="centered")
st.title("Inteligentny Asystent do Monitorowania Snu")

with st.form(key="sleep_form"):
    user_input = st.text_area(
        label=(
            "Opowiedz coś o swoim ostatnim śnie, nawykach lub "
            "problemach ze śnie."
        ),
        height=150,
    )
    submitted = st.form_submit_button("Analizuj mój sen")

if submitted and user_input.strip():
    with st.spinner("Analizuję…"):
        try:
            # Wygeneruj odpowiedź z OpenAI
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": (
                        "Jesteś asystentem pomagającym poprawić jakość snu"
                    )},
                    {"role": "user", "content": user_input},
                ],
                max_tokens=300,
                temperature=0.7,
            )
            answer = response.choices[0].message.content
        except Exception as e:
            answer = f"Wystąpił błąd: {e}"

    # Przygotuj folder z timestampem
    timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%d_%H-%M-%S-%f")
    base_path = f"{timestamp}/"

    # Zapis inputu i outputu do Azure Blob Storage
    try:
        upload_to_blob(base_path + "input.txt", user_input.encode('utf-8'))
        upload_to_blob(base_path + "output.txt", answer.encode('utf-8'))
    except Exception as storage_err:
        st.error(f"Błąd zapisu do storage: {storage_err}")

    # Wyświetl wynik
    st.subheader("Twoja spersonalizowana analiza:")
    st.write(answer)
else:
    st.info("Wpisz coś i kliknij „Analizuj mój sen”.")
