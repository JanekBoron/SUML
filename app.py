import os
import streamlit as st
from dotenv import load_dotenv
import openai

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

st.set_page_config(page_title="Asystent Snu", layout="centered")

 st.title(
     "Inteligentny Asystent do Monitorowania Snu"
 )

with st.form(key="sleep_form"):
    user_input = st.text_area(
        label=(
            "Opowiedz coś o swoim ostatnim śnie, nawykach lub "
            "problemach ze snem:"
        ),
        height=150,
    )
    submitted = st.form_submit_button("Analizuj mój sen")

if submitted and user_input.strip():
    with st.spinner("Analizuję…"):
        try:
            resp = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "Jesteś asystentem pomagającym poprawić jakość snu."},
                    {"role": "user", "content": user_input}
                ],
                max_tokens=300,
                temperature=0.7
            )
            answer = resp.choices[0].message.content
        except Exception as e:
            answer = f"Wystąpił błąd: {e}"

    st.subheader("Twoja spersonalizowana analiza:")
    st.write(answer)
else:
    st.info("Wpisz coś i kliknij „Analizuj mój sen”.")