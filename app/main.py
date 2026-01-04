from fastapi import FastAPI, Request, Depends, Form
from fastapi.responses import RedirectResponse
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session

from app.database import Base, engine, SessionLocal
from app.models import Product



app = FastAPI()

templates = Jinja2Templates(directory="app/templates")

Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def home(request: Request, db: Session = Depends(get_db)):
    products = db.query(Product).all()
    return templates.TemplateResponse(
        "index.html",
        {"request": request, "products": products}
    )

@app.post("/add")
def add_product(
    name: str = Form(...),
    description: str = Form(...),
    db: Session = Depends(get_db)
):
    product = Product(name=name, description=description)
    db.add(product)
    db.commit()
    return RedirectResponse("/", status_code=303)

@app.post("/delete/{product_id}")
def delete_product(product_id: int, db: Session = Depends(get_db)):
    product = db.query(Product).get(product_id)
    if product:
        db.delete(product)
        db.commit()
    return RedirectResponse("/", status_code=303)
