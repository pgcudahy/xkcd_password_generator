// Load and parse the words file
let wordList = [];

fetch(chrome.runtime.getURL('words.csv'))
  .then(response => response.text())
  .then(text => {
    wordList = text.split('\n').slice(1); // Skip header
  });

// Create context menu item
chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "generateXKCDPassword",
    title: "Generate XKCD password",
    contexts: ["editable"]
  });
});

// Generate cryptographically secure random numbers
function getRandomValues() {
  const array = new Uint32Array(4);
  crypto.getRandomValues(array);
  return Array.from(array);
}

// Handle context menu click
chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "generateXKCDPassword") {
    const randomValues = getRandomValues();
    const selectedWords = randomValues.map(value => {
      const index = value % wordList.length;
      return wordList[index];
    });
    
    // Send the generated password to content script
    chrome.tabs.sendMessage(tab.id, {
      action: "insertPassword",
      password: selectedWords.join('')
    });
  }
});
