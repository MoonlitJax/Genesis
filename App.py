import dash
from dash import dcc, html, Input, Output
import plotly.express as px
import pandas as pd
import psycopg2
import os

app = dash.Dash(__name__)

def get_data():
    try:
        conn = psycopg2.connect(
            host="db", database="allfather_data",
            user="admin", password="allfather_secure"
        )
        df = pd.read_sql("SELECT license_plate, latitude, longitude, timestamp FROM vehicle_tracks", conn)
        conn.close()
        return df
    except:
        return pd.DataFrame(columns=["license_plate", "latitude", "longitude"])

app.layout = html.Div(style={'backgroundColor': '#0a192f', 'color': '#00d4ff'}, children=[
    html.H1("ALLFATHER: TACTICAL HUD", style={'textAlign': 'center'}),
    dcc.Graph(id='live-update-graph'),
    dcc.Interval(id='interval-component', interval=5000, n_intervals=0)
])

@app.callback(Output('live-update-graph', 'figure'), [Input('interval-component', 'n_intervals')])
def update_graph(n):
    df = get_data()
    if df.empty:
        fig = px.scatter_mapbox(lat=[33.44], lon=[-112.07], zoom=10)
    else:
        fig = px.scatter_mapbox(df, lat="latitude", lon="longitude", color="license_plate",
                                 hover_name="license_plate", zoom=12)
    
    fig.update_layout(mapbox_style="carto-darkmatter", margin={"r":0,"t":0,"l":0,"b":0}, paper_bgcolor="#0a192f")
    return fig

if __name__ == '__main__':
    app.run_server(host='0.0.0.0', port=8050)
