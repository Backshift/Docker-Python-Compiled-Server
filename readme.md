## Commands

Build and Compile
```bash
# Compile and build
bash compile_and_build.sh

# Compile only
bash compile.sh
```

## Todo
* Implement pyarmor
```
pip install pyarmor
pyarmor pack -x "pyinstaller --onefile" your_script.py
```

## Dockerfile Example of using image

```
FROM monkeybusinez/pyinstaller-python-3.8-from-source:latest

# Set the working directory in the container
WORKDIR /app

# Copy bin into docker folder
COPY ./app/fast_bin /code/fast_bin

# Copy the requirements.txt file into the container
COPY requirements.txt /app/

# Install dependencies from the requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install PyInstaller and create a standalone executable
RUN python3.8 -m pip install --upgrade pip && \
    python3.8 -m pip install pyinstaller

#  && \
#    pyinstaller --onefile main.py

# Keep the container running (prevents it from exiting)
CMD ["/code/fast_bin", "--host", "0.0.0.0", "--port", "8081", "--reload"]
```

## Sources
https://github.com/mohammadhasananisi/compile_fastapi
https://github.com/orgs/pyinstaller/discussions/5669
