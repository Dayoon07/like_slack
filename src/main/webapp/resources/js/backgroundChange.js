function blackAndWhite() {
	const bg = document.getElementById("message-container");
	const chatHeader = document.getElementById("chatHeader");
	const mf = document.getElementById("mf");
	const chkbg = document.getElementById("chkbg");
	const sidebar = document.getElementById("sidebar");
	
	if (!chkbg.checked) {
		bg.classList.add("bg-gray-100");
		bg.classList.remove("bg-gray-900", "border-t", "border-b", "border-gray-700");
		
		chatHeader.classList.add("bg-blue-500");
		chatHeader.classList.remove("bg-gray-900");
		
		mf.classList.add("border-gray-300", "bg-gray-100");
		mf.classList.remove("bg-gray-900");
		
		sidebar.classList.remove("border-gray-700", "border-r");
	} else {
		bg.classList.add("bg-gray-900", "border-t", "border-b", "border-gray-700");
		bg.classList.remove("bg-gray-100");
		
		chatHeader.classList.add("bg-gray-900");
		chatHeader.classList.remove("bg-blue-500");
		
		mf.classList.add("bg-gray-900");
		mf.classList.remove("bg-gray-100", "border-gray-300", "border-t");
		
		sidebar.classList.add("border-gray-700", "border-r");
	}
}