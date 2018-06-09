# README
--------

> **Main process:**     
>   **`file.xps + xpstopdf => file.pdf + textract => file.txt`**


## Installation 

> MacOS Sierra 10.12    
> Ubuntu 16.04 LTS      

- Dependencies

    ```bash
    # MacOS Sierra 10.12
    brew install poppler antiword unrtf tesseract swig pkg-config
    ```

    ```bash
    # Ubuntu 16.04 LTS
    apt-get update
    apt-get -y install build-essential gcc make libpoppler-cpp-dev pkg-config libpulse-dev 
    apt-get -y install python-dev libxml2-dev libxslt1-dev
    apt-get -y install antiword unrtf libjpeg-dev poppler-utils pstotext flac tesseract-ocr ffmpeg lame libmad0 libsox-fmt-mp3 sox swig zlib1g-dev
    ```

- Install **`libgxps`**

    ```bash
    # MacOS Sierra 10.12
    brew install libgxps
    ```

    ```bash
    # Ubuntu 16.04 LTS
    apt-get -y install libgxps-utils
    ```

- Install **`textract`**
    
    - Set up python venv

        ```bash
        conda create --name xps2pdftxt python=3.6
        source activate xps2pdftxt
        pip install --upgrade pip
        ```

    - Install package from pip

        ```bash
        wget https://raw.githubusercontent.com/lzsdodo/xps2pdftxt/master/requirements.txt
        pip install -r requirements.txt
        # or 
        pip install textract==1.5.0
        ```

- Check if both are succeed installed

    ```bash
    which xpstopdf
    >>> /usr/local/bin/xpstopdf     # MacOS
    >>> /usr/bin/xpstopdf           # Ubuntu
    ```

    ```bash
    which textract
    >>> /path/to/venvs/xps2pdftxt/bin/textract   # Virtual environment
    ```


## Run Script

- Download script

    ```bash
    wget https://raw.githubusercontent.com/lzsdodo/xps2pdftxt/master/run.sh
    chmod a+x ./run.sh
    ```

- Move files to specific folder

    ```
    mkdir -p ./xps
    mv /path/*.xps ./xps
    ```

- Run

    ```bash
    # Only one arguments
    ./run.sh <xps_dir>
    # e.g.
    ./run.sh xps
    ```

- Output

    ```
    xps
    |____01.xps
    |____02.xps
    |
    |____output
         |
         |____pdf
         |    |____01.pdf
         |____txt
         |    |____01.txt
         |
         |____done_xps
         |    |____01.xps
         |____err_xps
         |    |____02.xps
         |
         |____done.log
         |____err.log
    ```

## Reference

- **[libgxps: xpstopdf](https://wiki.gnome.org/Projects/libgxps)**
- **[python: textract](https://github.com/deanmalmgren/textract)**

