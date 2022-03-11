# Hoge Bank - automated test scripts
There are 3 test suites
- User Sign up -- contains test cases for testing sign up process
- User Transaction -- contains test cases for testing withdrawal and deposit process
- User Account Balance -- contains test cases for testing account balance after deposit or withdraw process

## 3 things before you run the robot test scripts
### 1. Install Robot Framework
You can follow [Installation instructions](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)

### 2. Install Selenium Library
You can follow [Install Selenium Library](https://robotframework.org/SeleniumLibrary/#id8)

### 3. Install WebDriverManager
WebDriverManager will help you manage browsers version easier please visit [Install WebDriverManager](https://pypi.org/project/webdrivermanager/)

# How to Run test scripts
- Windows user open PowerShell or any shell script tools
- Linux/MacOS open Terminal

1. Clone or download code from repository
2. Change directory to "hoge-bank"
3. Run this command for all test suites 

>robot -v browser:{browser name} test_suites/

Example: 

>robot -v browser:chrome test_suites/


4. For specific test suite

>robot -v browser:{browser name} test_suites/{suite name}

Eample:

> robot -v browser:chrome test_suites/user_sign_up.robot

# The supported browsers
<table border="1">
<tbody><tr>
<th>Browser</th>
<th>Name(s)</th>
</tr>
<tr>
<td>Firefox</td>
<td>firefox, ff</td>
</tr>
<tr>
<td>Google Chrome</td>
<td>googlechrome, chrome, gc</td>
</tr>
<tr>
<td>Headless Firefox</td>
<td>headlessfirefox</td>
</tr>
<tr>
<td>Headless Chrome</td>
<td>headlesschrome</td>
</tr>
<tr>
<td>Internet Explorer</td>
<td>internetexplorer, ie</td>
</tr>
<tr>
<td>Edge</td>
<td>edge</td>
</tr>
<tr>
<td>Safari</td>
<td>safari</td>
</tr>
<tr>
<td>Opera</td>
<td>opera</td>
</tr>
<tr>
<td>Android</td>
<td>android</td>
</tr>
<tr>
<td>Iphone</td>
<td>iphone</td>
</tr>
<tr>
<td>PhantomJS</td>
<td>phantomjs</td>
</tr>
<tr>
<td>HTMLUnit</td>
<td>htmlunit</td>
</tr>
<tr>
<td>HTMLUnit with Javascript</td>
<td>htmlunitwithjs</td>
</tr>
</tbody></table>

# Test Report & Result
The robot framework will generate log.html and report.html files in the same folder that you run the script 
you can see test results in **report.html** and test detail in **log.html**
