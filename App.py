import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd

app = dash.Dash(__name__)

# Mock Data for initialization
df = pd.DataFrame([
    {"license_plate": "ABC1234", "lat": 33.475, "lon": -112.080},
    {"license_plate": "XYZ5678", "lat": 33.448, "lon": -112.074}
])

app.layout = html.Div(style={'backgroundColor': '#0a192f', 'color': '#00d4ff', 'padding': '20px'}, children=[
    html.H1("ALLFATHER: TACTICAL HUD v1.2"),
    dcc.Graph(figure=px.scatter_mapbox(df, lat="lat", lon="lon", hover_name="license_plate",
                                     zoom=11, height=600).update_layout(
                                         mapbox_style="carto-darkmatter",
                                         margin={"r":0,"t":0,"l":0,"b":0}))
])

if __name__ == '__main__':
    app.run_server(host='0.0.0.0', port=8050)
