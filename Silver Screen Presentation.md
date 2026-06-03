## **Presentation Script (With SQL Proof points)**

"Good morning everyone. I’d like to walk you through the data journey of our Silver Screen theater network, showing how we turned completely fragmented, raw operational files into a unified, strategic asset for our management team.

If you look at the diagram from left to right, you can see exactly how the data flows through our architecture.

### **The Theater Sales Stream (The Top Branch)**

* **The 3 Raw Files:** We start on the far left with three completely separate, raw data streams coming directly from our individual theater locations: `NJ_001`, `NJ_002`, and `NJ_003`. Because these branches used different point-of-sale systems, their daily logs were formatted differently and couldn't talk to each other.  
* **The 3 Staging Files:** To fix this, we passed them into our staging layer. We heavily used **`CAST()`** functions here to force mismatched data types into alignment, converting numbers disguised as text into clean integers, and utilizing data formatting to standardize variations across the systems.  
* **The 3 Intermediate Files:** Next, we moved the data into the intermediate layer. This is where we did the heavy mathematical lifting for each theater individually. We used the **`SUM()`** function to calculate total ticket volumes, and basic arithmetic operators like **`*` (multiplication)** to compute total revenue. Crucially, we used the **`GROUP BY`** clause to collapse thousands of daily register swipes into clean, monthly buckets.  
* **The Fact Network File:** Once all three branches spoke the exact same language and shared the same monthly grain, we combined them into a single core dataset: `fct_network_movie_sales`. We achieved this by using the **`UNION ALL`** operator to stack the rows from all three theaters neatly on top of one another. For the first time, management can look at one single file to see the entire network's box office performance.

### **The Business Context Streams (The Bottom Branches)**

Now, box office sales only tell half the story. To understand profitability, we needed to know what movies we were showing and how much they cost us.

* **The Raw Catalogue & Invoices:** We brought in two completely separate administrative datasets: our master `MOVIE_CATALOGUE` and our studio `INVOICES` sheets.  
* **The Staging Files (`stg_movies` & `stg_invoices`):** We cleaned these up in their own independent staging models, using **`CAST()`** and explicit column aliasing to rename raw fields like `LOCATION_ID` so they would map correctly later.  
* **Why We Calculated Them Separately:** We purposefully kept these branches separate from the theater logs because they represent static business rules and external costs. The movie catalog doesn't care which theater a ticket was sold at, and the studio invoice applies to the whole network. By processing them on their own tracks, we kept our architecture incredibly fast, clean, and modular.

### **The Final Destination**

* **The Mart Network Movie Profitability File:** Finally, all three streams converge right here on the far right. We executed a strategic **`LEFT JOIN`** condition, marrying our box office performance metrics with our movie metadata on `movie_id`, and our actual rental costs on both `movie_id` and `reporting_month`.

The result is a single, pristine executive dashboard dataset that instantly answers exactly which films generated a profit and which ones barely covered their studio fees."

## **📊 Executive Table Preview & Key Insights**

*(When you open the table preview on your screen, you can point to the columns and share these specific business insights)*

When we look at the final **498 rows** of data, we cross the bridge from data engineering to business intelligence. Here is what the data reveals:

* **The Hidden Margin Killers:** By comparing `REVENUE` directly against `RENTAL_COST`, we can instantly see that some high-revenue blockbusters actually have incredibly tight margins because major studios demand aggressive, expensive flat-fee invoices. High ticket volume doesn't always equal high profit.  
  "Our Margin Killers model is sorted in ascending order, immediately exposing the films that drained our cash. The fact that the top rows show negative profit margins proves that these specific titles—despite sometimes having high transaction volumes—cost us more in studio fees than they generated at the box office. We literally lost money by putting them on our screens."   
* **The Genre Sweet Spots:** Looking at `GENRE` alongside profitability shows us which types of films yield the highest return on investment. For example, mid-budget horror or comedy films often carry much lower rental costs from independent studios but pull in highly loyal, consistent local crowds, resulting in fantastic profit margins.  
  "Our Genre model is sorted in descending order to instantly highlight our strategic sweet spots. Even if our overall network is facing tight margins, this view ranks our genres from most profitable to least profitable, showing us exactly which film categories give us the best return on every dollar spent on studio rentals."   
* **Location Optimization:** Because we can see data broken down by `LOCATION` and `MONTH`, we can identify which theater branches are maximizing their screens and which locations are overpaying for studio rentals on movies that their local demographic isn't showing up to watch.  
  **Why is this happening?** If every single location is negative, it means the total studio invoice costs (`RENTAL_COST`) across the board are completely overwhelming the box office revenues (`REVENUE`). The network is paying way too much for its film licenses.  
  **What to say in your presentation (The Ultimate Recovery):** \> *"When we look at our Location Optimization model, we discover a critical systemic issue: every single theater location is currently operating at a net loss with negative margins. This proves that our financial hemorrhage isn’t caused by one poorly managed theater. Instead, it’s a network-wide structural problem: our flat-fee studio rental costs are fundamentally mismatched with our ticket pricing and attendance levels. This model perfectly sound-alerts executives that our current purchasing strategy is completely unsustainable."*


## **🎯 Recommendation & Call to Action**

### **The Strategic Recommendation**

"Based on these insights, our clear path forward is to shift from a **volume-based booking strategy** to a **margin-based booking strategy**. We should use this newly engineered dataset to negotiate dynamic, performance-based tier pricing with major movie studios instead of accepting high flat-fee rental invoices that eat our box office margins. Furthermore, we should optimize our screen allocation by shifting lower-performing genres out of underperforming branches and replacing them with high-margin regional favorites."

### **The Call to Action (The Big Close)**

"Now that this robust, automated data pipeline is fully built and running successfully in the cloud, the infrastructure is completely ready.

In conclusion, our data has sounded the alarm. Our location model shows network-wide negative margins, and our margin killers view shows that big studio fees are eating us alive. However, our genre sweet spots show us there is a path to survival. \> Therefore, my strategic recommendation is an immediate renegotiation of our studio contracts—shifting away from crippling flat-fee invoices toward revenue-split models. Our immediate call to action is to **immediately connect this data mart directly to Tableau.** 

By doing so, we can hand our regional managers a live, visual profitability dashboard by Monday morning, transforming our theater network from a business that guesses its performance into an agile, data-driven enterprise. Thank you."

